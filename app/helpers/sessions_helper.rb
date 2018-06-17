module SessionsHelper
  # Logs in the given user, stores username in the session.
  def log_in(user)
    session[:username] = user.username
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:username] = user.username
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:username)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:username)
    @current_user = nil
  end

  # Returns the current logged in user or nil.
  def current_user
    if (username = session[:username])
      @current_user ||= User.find_by(username: username)
    elsif (username = cookies.signed[:username])
      user = User.find_by(username: username)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  
end
