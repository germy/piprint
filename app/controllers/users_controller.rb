# app/controllers/users_controller.rb

class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:notice] = "User successfully created"
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:notice] = "User not created correctly"
      render action: 'new'
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
