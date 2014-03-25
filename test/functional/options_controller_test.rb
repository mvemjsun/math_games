require 'test_helper'

class OptionsControllerTest < ActionController::TestCase

  #
  # mock "test" method , converts to
  # def test_should_get_index
  #
  test "should get index with correct title" do
  	sign_in User.first
    get :index
    assert_response :success
    assert_select 'title', "Kids Maths - Options"
  end

  test "should like index route" do
  	sign_in User.first
	assert_recognizes({:controller => "options", :action => "index"}, "/options/index")
  end

  test "should like set route" do
  	sign_in User.first
	assert_recognizes({:controller => "options", :action => "set"}, "/options/set")
  end

end
