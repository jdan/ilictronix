class UsersController < ApplicationController

  before_filter :god_only, :only => [:index, :attach]

  def index
    @users = User.all
  end

  def attach
    @user = User.find(params[:id])
    @user.roles = params[:roles].collect { |r| Role.find(r.to_i) }

    respond_to do |format|
      if @user.save
        format.js
      else
        format.js { render 'error' }
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

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
