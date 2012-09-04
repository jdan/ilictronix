class CommentsController < ApplicationController

  before_filter :require_login
  before_filter :admin_or_original?, :only => [:edit, :update, :destroy]

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user

    if @comment.save
      redirect_to @comment.post, :notice => 'Comment saved!'
    else
      redirect_to @comment.post, :alert => 'Comment too short (minimum 10 chars)'
    end
  end

  def edit
    # we get @comment in admin_or_original?
    render :edit, :layout => 'no_sidebar'
  end

  def update
    # we get @comment in admin_or_original?

    if @comment.update_attributes(params[:comment])
      redirect_to @comment.post, :notice => 'Comment successfully updated.'
    else
      redirect_to @comment.post, :alert => 'Comment could not be updated.'
    end
  end

  def destroy
    # we get @comment in admin_or_original?

    respond_to do |format|
      if @comment.destroy
        format.js
      else
        format.js { render 'error' }
      end
    end
  end

  def admin_or_original?
    @comment = Comment.find(params[:id])
    return if current_user.has_role? :admin

    if current_user != @comment.user
      redirect_to @comment.post, :alert => 'You do not have access to this page.'
    end
  end

end
