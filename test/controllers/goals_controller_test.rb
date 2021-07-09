require 'test_helper'

class GoalsControllerTest < ActionDispatch::IntegrationTest
  test "should get configCalorie" do
    get goals_configCalorie_url
    assert_response :success
  end

end
