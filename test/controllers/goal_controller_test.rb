require 'test_helper'

class GoalControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get goal_index_url
    assert_response :success
  end

end
