class QuestionsController < ApplicationController
  include QuestionsHelper 
  before_filter :authenticate_user!
  before_filter :set_title

  #
  # start the game
  #
  def start
  	@title = "Playing #{session[:game_level]} #{session[:game_name]}"
    start_game_session
    game = Game.start_and_create({game_level: session[:game_level], 
                                  game_name: session[:game_name],
                                  user_id: current_user.id})
    session[:game_id] = game.id
  	render 'layouts/question', locals: {question: @question}
  end

  #
  # --- get next question
  #
  def next
    session[:questions_presented] += 1
    session[:questions_answered] += 1
    answer_right = false
    if (params[:answer].to_i == session[:correct_answer].to_i)
      session[:correct_answers] += 1 
      answer_right = true
    end

    game = Game.find(session[:game_id])
    game.refresh_game_data({qpresented: true, qanswered: answer_right})

    result = check_answer
    @wrong_answer = result[:status]
    @wrong_answer_message = result[:message]

    @question = present_question(session[:game_name],session[:game_level])
    session[:question] = @question
    session[:correct_answer] = @question[:answer]
    render 'layouts/question', locals: {question: @question, wrong_answer_message: @wrong_answer_message}
  end

  #
  # --- skip the question
  #
  def skip
    session[:questions_presented] += 1
    session[:questions_skipped] += 1
    
    game = Game.find(session[:game_id])
    game.refresh_game_data({qpresented: true, qskipped: true})

    @question = present_question(session[:game_name],session[:game_level])
    session[:question] = @question
    session[:correct_answer] = @question[:answer]
    render 'layouts/question', locals: {question: @question}
  end

  #
  # --- finish the game
  #
  def finish
    game = Game.find(session[:game_id])
    unless session[:game_status] == :end
      answer_right = false

      if game.status = 'S'
        if (params[:answer].to_i == session[:correct_answer].to_i)
          session[:correct_answers] += 1 
          answer_right = true
        end
        session[:questions_answered] += 1   
        game.refresh_game_data({qpresented: true, qanswered: answer_right, status: :end})
      end

      result = check_answer
      @wrong_answer = result[:status]
      @wrong_answer_message = result[:message] 

      session[:game_status] = :end

    end
    render :finish, locals: {:correct => session[:correct_answers], :total => session[:questions_presented], 
                             :started_at => game.created_at, :ended_at => game.updated_at}
  end

  def logout
    reset_session
    redirect_to :options_index
  end

end
