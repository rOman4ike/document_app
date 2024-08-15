require "test_helper"

class Main::SpaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get main_spa_index_url
    assert_response :success
  end
end
