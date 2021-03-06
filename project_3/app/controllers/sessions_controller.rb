#controller to manage the session
class SessionsController < ApplicationController
  #ensure that the user must log in
  skip_before_action :require_login, only: [:new, :create]
  
  def new
  end
  
  #method to login
  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to @user, notice: "Logged in!"
    else
      flash[:alert] = "Email or password is invalid!"
      redirect_to login_path
    end
  end

  #method to logout
  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out!"
  end

end
