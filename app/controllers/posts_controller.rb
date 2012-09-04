class PostsController < ApplicationController

  before_filter :require_login, :except => [:index, :show]
  before_filter :writers_only, :only => [:new, :create]
  before_filter :admin_or_original?, :only => [:edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @title = @post.title
  end

  def new
    @post = Post.new

    render :new, :layout => 'no_sidebar'
  end

  def create
    @post = Post.new(params[:post])
    @post.user = current_user

    if @post.save
      redirect_to @post, :notice => 'Post published successfully!'
    else
      render :new, :layout => 'no_sidebar'
    end
  end

  def edit
    # we get @post in admin_or_original?
    render :edit, :layout => 'no_sidebar'
  end

  def update
    # we get @post in admin_or_original?
    if @post.update_attributes(params[:post])
      redirect_to @post, :notice => 'Post updated successfully'
    else
      render :edit, :layout => 'no_sidebar'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, :notice => 'Post deleted successfully'
  end

  def admin_or_original?
    @post = Post.find(params[:id])
    return if current_user.has_role? :admin

    if current_user != @post.user
      redirect_to @post, :alert => 'You do not have access to this page'
    end
  end

end
