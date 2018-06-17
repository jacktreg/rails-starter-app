module UsersHelper
  include SessionsHelper

  def is_admin?
    logged_in? && current_user.admin
  end
end
