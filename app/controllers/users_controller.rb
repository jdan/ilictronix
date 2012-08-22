class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => 'Signed up! Please login to continue.'
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => 'Logged out.'
  end
end
