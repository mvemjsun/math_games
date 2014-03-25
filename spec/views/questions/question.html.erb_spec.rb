require 'spec_helper'

describe "Questions view" do

	context "Easy addition" do
		before(:each) do
			session[:game_name] = "add"
			session[:game_level] = "easy"
			@question = {:operand1 => 3, :operand2 => 9, :operator => "+"}
			render :template => 'layouts/question', :formats => [:html], :handlers => [:erb], :locals => {:question => @question}
		end

		it "Should show a question" do
			rendered.should have_selector("span", :name => "presented_question")
		end

		it "Should have the answer text box" do
			rendered.should have_selector("input", :id => "answer_input")		
		end

		it "Should have the answer next button" do
			rendered.should have_selector("button", :name => "next_button")		
		end

		it "Should have the skip question link" do
			rendered.should have_selector("a", :name => "skip_button")
		end

		it "Should have the finish game link" do
			rendered.should have_selector("a", :name => "finish_button")		
		end
	end
end