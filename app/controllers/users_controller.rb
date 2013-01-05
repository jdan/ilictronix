class UsersController < ApplicationController

  before_filter :god_only, :only => :attach
  before_filter :admin_only, :only => :index
  before_filter :logged_in_already?, :only => :new

  def index
    @users = User.all
    render :index, :layout => 'no_sidebar'
  end

  def attach
    @user = User.find(params[:id])
    if params[:roles]

      # we cannot remove `god` from any user
      if @user.has_role? :god
        should_have_god = true
      end

      @user.roles = params[:roles].collect { |r| Role.find(r.to_i) }

      if should_have_god && !@user.has_role?(:god)
        @user.roles << Role.where(:title => 'god')
      end
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
  end

  def new
    @user = User.new
    render :new, :layout => 'no_sidebar'
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

  def logged_in_already?
    return if current_user && current_user.has_role?(:god)
    if current_user
      redirect_to root_url, :alert => 'You are already logged in'
    end
  end
end
