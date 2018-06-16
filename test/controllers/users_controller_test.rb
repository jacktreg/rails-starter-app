require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @admin = users(:admin)
  end

  test "not logged in shouldn't get index" do
    get users_url
    assert_redirected_to root_path
  end

  test "non admin user shouldn't get index" do
    log_in_as(@user)
    get users_url
    assert_redirected_to root_path
  end

  test "user admin should get index" do
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
    get edit_user_path(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_path(@user),
    params: { user: { email: @user.email, username: @user.username,
      password: "password", password_confirmation: "password" } }
    assert_redirected_to user_path(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_path(@user, username: @user.username)
    end

    assert_redirected_to users_url
  end
end
