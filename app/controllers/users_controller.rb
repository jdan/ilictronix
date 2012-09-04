class UsersController < ApplicationController

  before_filter :god_only, :only => :attach
  before_filter :admin_only, :only => :index

  def index
    @users = User.all
  end

  def attach
    @user = User.find(params[:id])
    if params[:roles]
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
