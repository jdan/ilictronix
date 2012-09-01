class RolesController < ApplicationController

  before_filter :require_login
  before_filter do
    unless current_user.has_role? :god
      redirect_to root_url, :alert => 'You do not have access to this page'
    end
  end

  def index
    @roles = Role.all
  end

  def create
    @role = Role.new(:title => params[:title])

    respond_to do |format|
      if @role.save
        format.js
      else
        format.js { render 'error' }
      end
    end
  end

  def destroy
    @role = Role.find(params[:id])

    respond_to do |format|
      if @role.destroy
        format.js
      else
        format.js { render 'error' }
      end
    end
  end
end
