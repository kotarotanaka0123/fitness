require 'test_helper'

class FitnessControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fitness_index_url
    assert_response :success
  end

end
