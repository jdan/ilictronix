class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => 'Logged in.'
    else
      flash.now.alert = 'Invalid username/password combination'
    end
  end
end
