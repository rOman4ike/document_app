require "test_helper"

class Manage::SpaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manage_spa_index_url
    assert_response :success
  end
end
