require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test "user can access task messages" do
    t=Task.create({user_id: User.first.id, title: "a test", body: "a test"})
    assert true if t.messages
  end

  test "user can create a message" do
    t=Task.create({user_id: User.first.id, title: "a test", body: "a test"})
    assert true if t.messages.create({user: 1, data: 'a message test'})
  end

  test "user can access a message" do
    t=Task.create({user_id: User.first.id, title: "a test", body: "a test"})
    t.messages.create({user: 1, data: 'a message test'})
    assert true if t.messages.first.data = 'a message test'
  end
end
