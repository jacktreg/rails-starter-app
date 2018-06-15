module UsersHelper
  include SessionsHelper

  def current_user_path
    if !current_user.nil?
      user_path(current_user, username: current_user.username)
    end
  end
end
