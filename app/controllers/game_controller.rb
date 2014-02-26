class GameController < ApplicationController

  before_filter :set_title

  def set_title
    @title = "Playing "+session[:game_level]+ " "+session[:game_name]
  end

  def play
    if session[:game_level]
      @question = GameHelper.get_math_question_details(session[:game_level],session[:game_name])
      session[:answer] = @question[:answer]
      render 'layouts/question'
    else
      redirect_to :root
    end
  end

  def next_question

    if params[:answer] != session[:answer].to_s
      flash.now[:error] = "Wrong answer." 
    else
      session[:questions_answered] += 1
    end

    session[:questions_presented] += 1
    @question = GameHelper.get_math_question_details(session[:game_level],session[:game_name])
    session[:answer] = @question[:answer]
    render 'layouts/question'
  end

  def skip_question
    if session[:game_level]
      session[:questions_presented] += 1
      @question = GameHelper.get_math_question_details(session[:game_level],session[:game_name])
      session[:answer] = @question[:answer]
      render 'layouts/question'
    else
      redirect_to :root
    end
  end

  def finish_game

    if session[:game_level]

      if params[:answer] == session[:answer].to_s
        session[:questions_answered] += 1
      end

      @message = "You scored "+session[:questions_answered].to_s + " out of "+session[:questions_presented].to_s+"."
      x = session[:questions_answered].to_f
      y = session[:questions_presented].to_f
      @percent = (x/y)*100.0 if y > 0

      case @percent

      when 0.0 .. 0.0
        @message << " Keep trying and don't give up."
      when 1.0 .. 70.0
        @message << " Well done. you are getting there."
      when 71.0 .. 90.0
        @message << " Excellent. Keep up the good work"
      when 91.0 .. 100.0
        @message << " You are the best."
      end
    else
      redirect_to :root
    end
  end
end
