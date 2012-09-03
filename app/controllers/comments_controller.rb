class CommentsController < ApplicationController

  before_filter :require_login
  before_filter :admin_only, :only => :destroy

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user

    if @comment.save
      redirect_to @comment.post, :notice => 'Comment saved!'
    else
      redirect_to @comment.post
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.destroy
        format.js
      else
        format.js { render 'error' }
      end
    end
  end

end
