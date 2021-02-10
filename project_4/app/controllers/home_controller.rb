class HomeController < ApplicationController
  def index
    @role = current_user.role
  end
end
