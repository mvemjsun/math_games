require 'spec_helper'

describe OptionsController do

	before(:each) do
		sign_in User.first
	end

	it "Should successfully get the index page" do
		get :index
		expect(response).to render_template("index")
	end

	it "should set correct page title on index" do
		get :index
		assigns(:title).should == "Kids Maths - Select Options"
	end

	it "should set the level and game type" do
		post :set ,{:game_level => "easy", :game_name => "add"}
		session[:game_level].should == "easy"
		session[:game_name].should == "add"
	end

	it "Set action should redirect to questions/start" do
		post :set ,{:game_level => "easy", :game_name => "add"}
		expect(response).to redirect_to("http://test.host/questions/start")
	end

	it "Should show error when trying to start game without level" do
		post :set ,{:game_level => "", :game_name => "add"}
		expect(response).to render_template("index")
		flash[:danger].should contain("Please select a level and game.")
	end

	it "Should show error when trying to start game without game type" do
		post :set ,{:game_level => "easy", :game_name => ""}
		expect(response).to render_template("index")
		flash[:danger].should contain("Please select a level and game.")
	end

	it "Should show error when trying to start game without level or game" do
		post :set ,{:game_level => "", :game_name => ""}
		expect(response).to render_template("index")
		flash[:danger].should contain("Please select a level and game.")
	end		
end
