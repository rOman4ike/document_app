require "test_helper"

class Directory::SpaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get directory_spa_index_url
    assert_response :success
  end
end
