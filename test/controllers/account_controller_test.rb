require "test_helper"

class AccountControllerTest < ActionDispatch::IntegrationTest
  test "should get profile" do
    get account_profile_url
    assert_response :success
  end

  test "should get settings" do
    get account_settings_url
    assert_response :success
  end

  test "should get history" do
    get account_history_url
    assert_response :success
  end
end
