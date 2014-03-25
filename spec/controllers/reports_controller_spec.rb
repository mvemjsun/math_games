require 'spec_helper'

describe ReportsController do

  before(:each) do
    sign_in User.first
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'show/<date>'" do

    it "returns http success" do
      get 'show', {game_date: '2014-03-24'}
      response.should be_success
    end
  end

end
