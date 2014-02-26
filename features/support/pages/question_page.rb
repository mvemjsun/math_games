require 'page-object'

class QuestionPage
	include PageObject

	list_item(:question_text, :id => "question_text")
	text_field(:input_answer, :id => "answer_input")
	text_field(:expected_answer, :id => "expected_answer")

	link(:skip, :id => "skip_url")
	link(:finish, :id => "finish_url")
	button(:next_question, :id => "next_button")

	def presented_question
		question_text
		debugger
	end

	def answer_question(options) 

		total = options[:total]
		correct = options[:correct].nil? ? 0 : options[:correct] 
		wrong = options[:wrong].nil? ? 0 : options[:wrong] 
		skipped = options[:skip].nil? ? 0 : options[:skip]

		if (correct == 0) && ((wrong < total) || (skipped < total))
			correct = total - (wrong + skipped)
		end 

		attempted_total = 0
		attempted_correct = 0
		attempted_wrong = 0
		attempted_skip = 0

		while attempted_total < total do

			case 

			when attempted_correct < correct
				answer_question_correctly
				attempted_total += 1
				attempted_correct += 1
				self.next_question if (attempted_total < total)
				next

			when attempted_wrong < wrong
				answer_question_wrong
				attempted_wrong += 1
				attempted_total += 1
				self.next_question if (attempted_total < total)
				next

			when attempted_skip < skipped
				attempted_skip += 1
				attempted_total += 1
				self.skip if attempted_total <= total
				next
			end			
		end
	end

	def answer_questions_and_stay(options)
		answer_question(options)
	end

	def answer_questions_and_finish(options)
		answer_question(options)
		self.finish
	end

	def answer_question_correctly
		self.input_answer = self.expected_answer
	end

	def answer_question_wrong
		self.input_answer = 9999999
	end

end