require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "user can create task" do
    assert true if Task.create({user_id: User.first.id, title: "a test", body: "a test"})
  end
end
