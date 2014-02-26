When(/^I enter a "(.*?)" answer$/) do |answer_state|

	case answer_state
	when "right" 
		on(QuestionPage).input_answer = on(QuestionPage).expected_answer
	when "wrong"   
		on(QuestionPage).input_answer = 787878787
	end
end

Then(/^the answer box should turn "(.*?)"$/) do |colour|
	case colour
	when "red" 
		@browser.input(:id => "answer_input").style.should == "background-color: rgb(198, 15, 19);"
	when "green"
		@browser.input(:id => "answer_input").style.should == "background-color: rgb(93, 164, 35);"
	end	
end

And(/^I answer "(#{QUESTION_COUNT})" out of "(#{QUESTION_COUNT})" questions$/) do |answered_questions,asked_questions|
	on(QuestionPage).answer_questions_and_finish({:total => asked_questions, :correct => answered_questions})
end

And(/^I answer "(#{QUESTION_COUNT})" wrong out of "(#{QUESTION_COUNT})" questions$/) do |wrong_questions,asked_questions|
	on(QuestionPage).answer_questions_and_finish({:total => asked_questions, :wrong => wrong_questions})
end

And(/^I answer "(#{QUESTION_COUNT})" questions and skip "(#{QUESTION_COUNT})" questions$/) do |asked_questions,skipped_questions|
	on(QuestionPage).answer_questions_and_stay({:correct => asked_questions, :skip => skipped_questions, :total => asked_questions + skipped_questions})
end