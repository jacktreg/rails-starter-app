class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  include UsersHelper
  
  layout "application"

  def home

  end

  def about

  end

  def contact

  end

end
