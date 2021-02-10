#controller for the application
class ApplicationController < ActionController::Base
  #helper methods to check if user is logged in and is the current user
  helper_method :logged_in?, :current_user
  
  #requires user to log in to access methods
  before_action :require_login
  
  #ensures user is the current user so they don't access unauthorized data
  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  #checks if user is logged in
  def logged_in?
    !!current_user
  end

  #ensures that user is logged in to access certain content
  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path # halts request cycle
    end
  end

  #defines who is authorized to access content
  def authorized
    redirect_to login_path unless logged_in?
  end
end
