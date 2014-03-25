class ReportsController < ApplicationController
  before_filter :authenticate_user!
  include ReportsHelper

  def show
  	unless params[:game_date]
		@chart_full_summary = LazyHighCharts::HighChart.new('graph') do |f|
		  f.title(:text => "Summary of performance till date.")
		  # "add", "divide", "multiply", "subtract"
		  f.xAxis(:categories => GameName.select(:name).map {|x| x.name}.sort)
		  f.series(:name => "Questions Asked", :yAxis => 0, :data => Game.questions_asked_so_far(current_user))
		  f.series(:name => "Questions Answered", :yAxis => 1, :data => Game.questions_answered_so_far(current_user))

		  f.yAxis [
		    {:title => {:text => "Asked", :margin => 70} },
		    {:title => {:text => "Answered"}, :opposite => true},
		  ]

		  f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
		  f.chart({:defaultSeriesType=>"column"})
		end 
	end

	if params[:game_date]
		@chart_date_summary_add = date_summary({date: params[:game_date],user_id: current_user,game_name: "add"})
		@chart_date_summary_subtract = date_summary({date: params[:game_date],user_id: current_user,game_name: "subtract"})
		@chart_date_summary_multiply = date_summary({date: params[:game_date],user_id: current_user,game_name: "multiply"})
		@chart_date_summary_divide = date_summary({date: params[:game_date],user_id: current_user,game_name: "divide"})
	end
  end


end
