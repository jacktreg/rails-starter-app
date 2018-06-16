module UsersHelper
  include SessionsHelper

  def current_user_show_path
    if !current_user.nil?
      user_path(current_user, username: current_user.username)
    end
  end

  def current_user_edit_path
    if !current_user.nil?
      edit_user_path(current_user, username: current_user.username)
    end
  end

  def create_user_path
    url_for({
      controller: "users",
      action: "create"
    })
  end

  def current_user_update_path
    url_for({
      controller: "users",
      action: "update",
      params: { username: current_user.username }
    })
  end
end
