module QuestionsHelper

	def set_title
		@title = "Playing #{session[:game_level]} #{session[:game_name]}"
	end

	# Hash
	def present_question(game,level)
		{
			:add =>      -> {get_add_question level},
			:subtract => -> {get_subtract_question level},
			:multiply => -> {get_multiply_question level},
			:divide =>   -> {get_divide_question level},
		}[game.to_sym].call
	end

	# Example configuration
	#{"add"=>"easy:10 medium:30 hard:100", 
	#"subtract"=>"easy:15 medium:30 hard:100", 
	#"multiply"=>"easy:5  medium:10 hard:15", 
	#"divide"=>"easy:10 medium:50 hard:100"}

	def configuration(game)
		APP_CONFIG[game.to_s]
	end

	#
	# get the operand limit for the current game and level
	#
	def operand_limit(game,level)
		level_limits=configuration(game)
		limit_for_game = level_limits.select {|k| k.index(level).nil? == false}
		configuration(game)[limit_for_game.first.first].to_s
	end

	def get_add_question(level)
		limit = operand_limit(:add,level)
		operand1 = rand(limit.to_i)
		operand2 = rand(limit.to_i)
		answer = operand1 + operand2
		{:operand1 => operand1, :operand2 => operand2, :operator => "+", :answer => answer}
	end

	def get_subtract_question(level)
		limit = operand_limit(:subtract,level)
		operand1 = rand(limit.to_i)
		operand2 = rand(limit.to_i)
		if operand1 < operand2
			temp = operand1
			operand1 = operand2
			operand2 = temp
		end
		answer = operand1 - operand2
		{:operand1 => operand1, :operand2 => operand2, :operator => "-", :answer => answer}
	end

	def get_multiply_question(level)
		limit = operand_limit(:multiply,level)
		operand1 = rand(limit.to_i)
		operand2 = rand(limit.to_i)
		answer = operand1 * operand2
		{:operand1 => operand1, :operand2 => operand2, :operator => "*", :answer => answer}
	end

	def get_divide_question(level)
		limit = operand_limit(:divide,level)
		operand1 = rand(1 .. limit.to_i)
		operand2 = operand1 * rand(limit.to_i)
		answer = operand2 / operand1
		{:operand1 => operand2, :operand2 => operand1, :operator => "/", :answer => answer}
	end

	def check_answer
		wrong_answer = false
		wrong_answer_message = nil
	    unless (params[:answer].to_i == session[:correct_answer].to_i)
	      session[:wrong_answers] += 1 
	      wrong_answer = true
	      wrong_answer_message = "#{session[:question][:operand1] } #{session[:question][:operator]} #{session[:question][:operand2]} = #{session[:question][:answer]}"
	    end
	    {:status => wrong_answer, :message => wrong_answer_message}
	end

end
