module ReportsHelper
	#
	# build chart options for a user, game and date combination
	#
	def date_summary(options)
		game_date = options[:date]
		game_user = options[:user_id]
		game_name = options[:game_name]

		@chart_date_summary = LazyHighCharts::HighChart.new('graph') do |f|
		  f.title(:text => "Summary for "+game_name+ " on "+game_date)

		  qasked = Game.questions_on_date({date: game_date,game_name: game_name, user: game_user, question: :qpresented })
		  qanswered = Game.questions_on_date({date: game_date,game_name: game_name, user: game_user, question: :qanswered})

		  # easy hard medium
		  f.xAxis(:categories => GameLevel.select(:level).map {|x| x.level}.sort)

		  f.series(:name => "Questions Asked", :yAxis => 0, :data => qasked)
		  f.series(:name => "Questions Answered", :yAxis => 1, :data => qanswered)

		  f.yAxis [
		    {:title => {:text => "Asked", :margin => 70} },
		    {:title => {:text => "Answered"}, :opposite => true},
		  ]

		  f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
		  f.chart({:defaultSeriesType=>"column"})
		end
	end
end
