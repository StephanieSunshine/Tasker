require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "first test user exists" do
    assert true if User.first
  end

  test "second test user exists" do
    assert true if User.last
  end



end
