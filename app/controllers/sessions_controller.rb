class SessionsController < ApplicationController

  before_filter :logged_in_already?, :only => [:new, :create]

  def new
    render :new, :layout => 'no_sidebar'
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => "Logged in. Welcome, #{params[:username]}!"
    else
      flash.now.alert = 'Invalid username/password combination'
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => 'Logged out!'
  end

  def logged_in_already?
    return if current_user && current_user.has_role?(:god)
    if current_user
      redirect_to root_url, :alert => 'You are already logged in'
    end
  end
end
