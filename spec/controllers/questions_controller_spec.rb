require 'spec_helper'

describe QuestionsController do

  before(:each) do
    sign_in User.first
    session[:game_name] = "add"
    session[:game_level] = "easy"   
    session[:questions_presented] = 0
    session[:questions_answered] = 0
    session[:correct_answers] = 0
    session[:questions_skipped] = 0
    session[:wrong_answers] = 0 
    session[:game_id] = 1
    get :start    
  end


  describe "GET 'start'" do
    it "returns http success" do
      response.should be_success
    end

    it "should initialize questions presented count" do
      session[:questions_presented].should == 1
    end

    it "should initialize questions answered count" do
      session[:questions_answered].should == 0
    end

    it "should redirect to layouts/question" do
      expect(response).to render_template("layouts/question")
    end
  end

  #
  # checks that the counts gets incremented correctly
  #
  describe "GET next" do

    it "should increment the questions presented count" do
      expect{
        get :next
      }.to change{session[:questions_presented]}.by(1)
    end

    it "should increment the questions answered count" do
      expect{
        get :next
      }.to change{session[:questions_answered]}.by(1)
    end

  end

end
