class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
   
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  
  
  private
  def user_params #defnes what variables can be edited
    params.require(:user) .permit(:name, :email, :password, :password_confirmation, :remember_token )
  end
end
    

