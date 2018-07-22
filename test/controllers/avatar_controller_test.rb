require 'test_helper'

class AvatarControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get avatar_index_url
    assert_response :success
  end

end
