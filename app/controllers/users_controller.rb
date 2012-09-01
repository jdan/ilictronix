class UsersController < ApplicationController

  before_filter :god_only, :only => [:index, :attach]

  def index
    @users = User.all
  end

  def attach
    @user = User.find(params[:id])
    if params[:roles]
      @user.roles = params[:roles].collect { |r| Role.find(r.to_i) }
    else
      @user.roles = []
    end

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
    @roles = Role.all.collect{ |r| [r.title, r.id] }
    @selected_roles = Role.all.find_all{ |r| @user.has_role?(r.title.to_sym) }.collect{ |sr| sr.id }
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
