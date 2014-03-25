class OptionsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  	@title = "Kids Maths - Select Options"
    reset_game_session
  end

  def set
  	session[:game_level] = params[:game_level]
  	session[:game_name]= params[:game_name]
  	if params[:game_level].blank? || params[:game_name].blank?
  		flash[:danger] = "Please select a level and game."
  		render :index
  	else
  		redirect_to :questions_start
  	end
  end

  def home
    redirect_to :options_index
  end
end