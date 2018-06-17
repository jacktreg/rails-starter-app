module UsersHelper
  include SessionsHelper

  def is_admin?
    logged_in? && current_user.admin
  end

  def current_user?(user)
    user == current_user
  end
end
