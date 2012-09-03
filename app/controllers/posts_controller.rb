class PostsController < ApplicationController

  before_filter :require_login, :except => [:index, :show]
  before_filter :writers_only, :only => [:new, :create, :edit, :update]

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
    @post = Post.find(params[:id])

    render :edit, :layout => 'no_sidebar'
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to @post, :notice => 'Post updated successfully'
    else
      render :edit, :layout => 'no_sidebar'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def can_write?
    current_user.has_role?(:writer) || current_user.has_role?(:god)
  end

end
