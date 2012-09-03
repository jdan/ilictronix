class RolesController < ApplicationController

  before_filter :require_login
  before_filter :god_only

  def index
    @roles = Role.all

    render :index, :layout => 'no_sidebar'
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
