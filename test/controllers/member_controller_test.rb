require 'test_helper'

class MemberControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get member_index_url
    assert_response :success
  end

  test "should get addTask" do
    get member_addTask_url
    assert_response :success
  end

  test "should get changeTask" do
    get member_changeTask_url
    assert_response :success
  end

  test "should get assignTask" do
    get member_assignTask_url
    assert_response :success
  end

end
