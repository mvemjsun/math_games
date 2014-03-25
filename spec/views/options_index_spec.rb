require 'spec_helper'

describe "Options index view" do

	before(:each) do
		render :template => 'options/index', :formats => [:html], :handlers => [:erb]
	end

	it "Should display 3 game levels" do
		["easy","medium","hard"].each do |level|
			rendered.should have_selector("button",
			:name => level
			)
		end
	end

	it "Should display 4 game types" do
		["add","subtract","multiply","divide"].each do |level|
			rendered.should have_selector("button",
			:name => level
			)
		end
	end

	it "Should render a form (hidden) to capture selected options" do
		rendered.should have_selector("form",
			:name => "options_form",
			:action=>"/options/set")
		rendered.should have_selector("input", :name => "game_level")
		rendered.should have_selector("input", :name => "game_name")
	end

	it "Should display message to choose a level" do
		rendered.should match(/Please choose a Level/)
	end	

	it "Should display message to choose a game" do
		rendered.should contain("Please choose a Game")
	end		
end