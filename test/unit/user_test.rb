require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test "invalid user should not be saved" do
	  user = User.new
	  assert !user.save, "Invalid user cant be saved"
	end

	test "valid user should be saved" do
		user = User.new
		user.email = "user"+rand(101..200).to_s+"@email.com"
		user.name = "Mr Test user"
		user.password = "password1234"
		assert user.save, "User with valid attributes has been saved"
	end
end