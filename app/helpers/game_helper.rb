module GameHelper
	#
	# returns a hash of question operands , question math symbol and answer
	# question = {:operand1 => 12, :operand2 => 32, :operation => "+", :answer => 44}
	#
	def self.get_math_question_details(game_level,game_name)
		self.get_operands(game_level,game_name)
	end

	def self.get_operands(game_level,game_name)

		case 

		when game_level == "easy"
			operand1 = Random.rand(1..9)
			operand2 = Random.rand(1..9)

		when game_level == "medium"
			operand1 = Random.rand(1..9)
			operand2 = Random.rand(10..20)

		when game_level == "hard"
			operand1 = Random.rand(21..50)
			operand2 = Random.rand(51..99)

		end

		#
		# --- Operation
		#
		case 

		when game_name == "add"
			operation = "+"
			answer = operand1 + operand2

		when game_name == "subtract"
			operation = "-"
			if operand2 > operand1
				tmp = operand1
				operand1 = operand2
				operand2 = tmp
			end
			answer = operand1 - operand2

		when game_name == "multiply"
			operation = "*"
			answer = operand1 * operand2

		when game_name == "divide"
			operation = "/"
			operand1 = operand2 * rand(2..12)
			answer = operand1 / operand2
		end
		
		{:operand1 => operand1, :operand2 => operand2, :operation => operation, :answer => answer}

	end	
end
