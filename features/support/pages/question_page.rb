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

end