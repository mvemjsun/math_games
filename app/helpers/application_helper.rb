module ApplicationHelper

	def reset_game_session
	  	session[:game_level] = ""
	  	session[:game_name] = ""
	    session[:questions_presented] = 0
	    session[:questions_answered] = 0
	    session[:correct_answers] = 0
	    session[:questions_skipped] = 0
	    session[:wrong_answers] = 0
	    session[:game_status] = :end
	end

	def start_game_session
	  	session[:questions_presented] = 1
	  	session[:questions_answered] = 0
	    session[:correct_answers] = 0
	    session[:wrong_answers] = 0
	    @question = present_question(session[:game_name],session[:game_level])
	    session[:question] = @question
	    session[:correct_answer] = @question[:answer]
	    session[:game_status] = :started
	end
end
