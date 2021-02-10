#controller for user methods
class UsersController < ApplicationController
  #require user logs in
  skip_before_action :require_login, only: [:new, :create]
  
  #create new user
  def new
    @user = User.new
  end

  #makes new user if valid
  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.save
      redirect_to @user
    else
      flash[:alert] = "The information you entered was invalid."  
      redirect_to signup_path
    end
  end

  #shows user their page and no one elses
  def show
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to @user
    end
  end
  
  private

  #parameters needed to sign up for user
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
