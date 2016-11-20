require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(name:"Okashiki Kenji", email:"kenji.okashiki@rakus.co.jp")
	end

	test  "should be valid?" do
		assert @user.valid?
	end

	test "name should be present" do
		@user.name = "   "
	  assert_not  @user.valid?
	end

	test "email should be present" do
		@user.email = "     "
	  assert_not @user.valid?
	end

	test "name should not be too long" do
	  @user.name = "a"*51
		assert_not @user.valid?
	end

	test "email should not be too long" do
	  @user.email = "a"*250 + "@email.com"
		assert_not @user.valid?
	end

	test "email validation should accept valid addresses" do
		valid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert_not @user.valid?, "#{valid_address.inspect} should be valid"
		end
	  assert true
	end

	test "email address should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
	  assert_not duplicate_user.valid?
	end
end
