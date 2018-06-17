require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @admin = users(:admin)
  end

  test "non admin user can only edit their page" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    get edit_user_path(@admin)
    assert_redirected_to root_path
  end

  test "non admin user can only update their account" do
    log_in_as(@user)
    patch user_path(@admin), params: { user: { username:  "Michael",
                                              email: "foo@valid.com",
                                              password:              "aaaaaaaa",
                                              password_confirmation: "aaaaaaaa" },
                                       }
    assert_redirected_to root_path
  end

  test "admin user can edit any user" do
    log_in_as(@admin)
    get edit_user_path(@user)
    assert_template "users/edit"
  end

  test "unsuccessful not logged in edit" do
    patch user_path(@user), params: { user: { username:  "Michael",
                                              email: "foo@valid.com",
                                              password:              "aaaaaaaa",
                                              password_confirmation: "aaaaaaaa" } }
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "successful admin edit" do
    log_in_as(@admin)
    patch user_path(@user), params: { user: { username:  "Michael",
                                              email: "foo@valid.com",
                                              password:              "aaaaaaaa",
                                              password_confirmation: "aaaaaaaa" },
                                       }
    assert_redirected_to user_path(@user)
    assert_not flash.empty?
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username:  "Michael",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    assert_redirected_to edit_user_path(@user)
    assert_not flash.empty?
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    username  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { username:  username,
                                              email: email,
                                              password:              "password",
                                              password_confirmation: "password" } }
    assert_not flash.empty?
    @user.reload
    assert_redirected_to @user
    assert_equal username,  @user.username
    assert_equal email, @user.email
  end

  test "user stays logged in after editing their account" do
    log_in_as(@user)
    username  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { username:  username,
                                              email: email,
                                              password:              "password",
                                              password_confirmation: "password" } }
    @user.reload
    get edit_user_path(@user)
    assert_template 'users/edit'
  end

  test "admin user stays logged in after editing another account" do
    log_in_as(@admin)
    username  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { username:  username,
                                              email: email,
                                              password:              "password",
                                              password_confirmation: "password" } }
    @user.reload
    get edit_user_path(@admin)
    assert_template 'users/edit'
  end
end
