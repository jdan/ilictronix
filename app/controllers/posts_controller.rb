class PostsController < ApplicationController

  before_filter :require_login, :except => [:index, :tagged, :show]
  before_filter :writers_only, :only => [:new, :create]
  before_filter :admin_or_original?, :only => [:edit, :update, :publicize]
  before_filter :admin_or_original_if_private, :only => [:show]

  before_filter :attach_tag_list, :only => [:edit]

  def index
    # primitive pagination
    @page = (params[:page] || 1).to_i
    offset = 3 * (@page - 1)

    @posts = Post.where(:public => true).all(:offset => offset, :limit => 3)

    respond_to do |format|
      format.html
      format.json { render :json => @posts.to_json }
    end
  end

  def tagged
    # uses primitive pagination
    @page = (params[:page] || 1).to_i
    offset = 3 * (@page - 1)

    @tag = Tag.find_by_title(params[:tag])
    if @tag.nil?
      @posts = []
    else
      @posts = @tag.posts.where(:public => true).all(:offset => offset, :limit => 3)
    end

    respond_to do |format|
      format.html { render 'index' }
      format.json { render :json => @posts.to_json }
    end
  end

  def show
    # we get @post in admin_or_original_if_private
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
    @post = Post.find_by_slug!(params[:id])
    @post.destroy
    redirect_to posts_path, :notice => 'Post deleted successfully'
  end

  # POST /posts/:id/publicize
  # makes a post public, returns JS
  def publicize
    @post = Post.find_by_slug!(params[:id])
    @post.public = true

    respond_to do |format|
      if @post.save
        format.js
      else
        format.js { render 'error' }
      end
    end
  end

  private
  def admin_or_original?
    @post = Post.find_by_slug!(params[:id])
    return if current_user.has_role? :admin

    if current_user != @post.user
      redirect_to @post, :alert => 'You do not have access to this page'
    end
  end

  def admin_or_original_if_private
    @post = Post.find_by_slug!(params[:id])
    return if current_user && current_user.has_role?(:admin)

    if !@post.public && !(current_user && current_user == @post.user)
      redirect_to root_url, :alert => 'You do not have access to this page'
    end
  end

  def attach_tag_list
    @post.tag_list = @post.tags.map{ |t| t.title }.join(' ')
  end

end
