class UsersController < ApplicationController
  
  def new
  end
  
  private
  def user_params #defnes what variables can be edited
    params.require(:user) .permit(:name, :email, :password, :passwordconfirmation)
  end
  
end
