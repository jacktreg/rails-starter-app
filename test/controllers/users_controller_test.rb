require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @admin = users(:admin)
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should get index when logged in" do
    log_in_as(@user)
    get users_url
    assert_response :success
  end

  test "should get index when admin logged in" do
    log_in_as(@admin)
    get users_url
    assert_response :success
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: "unique@example.com",
        username: "unique", password: "password",
        password_confirmation: "password" } }
    end

    assert_redirected_to user_path(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_response :success
  end

  test "should update user" do
    log_in_as(@user)
    patch user_path(@user), params: { user: { email: @user.email, username: @user.username,
      password: "password", password_confirmation: "password" } }
    assert_redirected_to @user
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_path(@user, username: @user.username)
    end
    assert_redirected_to users_url
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { username: @user.username,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
