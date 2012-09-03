class CommentsController < ApplicationController

  before_filter :require_login

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user

    if @comment.save
      redirect_to @comment.post, :notice => 'Comment saved!'
    else
      redirect_to @comment.post
    end
  end
end
