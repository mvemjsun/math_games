require 'spec_helper'
require 'debugger'

describe User do

  before(:each) do
	  user = double('user')
	  user.stub :authenticate! => user
	  user.stub :current_user => user 
  end

  it "should not be saved if email is blank" do
  	user = User.new
  	user.save
  	expect(user.errors.messages[:email].first).to eq("can't be blank")
  end

  it "should not be saved if password is blank" do
  	user = User.new
  	user.save
  	expect(user.errors.messages[:password].first).to eq("can't be blank")
  end 

  it "should be saved if correct attributes supplied" do
  	user = User.new
  	user.email = "emailxxx@example.com"
  	user.name = "userxxx"
  	user.password = "password1234"
	expect{
	  user.save
	}.to change{ User.count }.by(1)
  end 
end