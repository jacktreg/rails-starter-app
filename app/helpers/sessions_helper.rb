module SessionsHelper
  # Logs in the given user, stores username in the session.
  def log_in(user)
    session[:username] = user.username
  end

  def log_out
    session.delete(:username)
    @current_user = nil
  end

  # Returns the current logged in user or nil.
  def current_user
    @current_user ||= User.find_by(username: session[:username])
  end

  def logged_in?
    !current_user.nil?
  end
end
