class ApplicationController < ActionController::Base
  protect_from_forgery

  def writers_only
    filter_role(:writer)
  end

  def admin_only
    filter_role(:admin)
  end

  def god_only
    filter_role(:god)
  end

  private
  def filter_role(role)
    unless current_user && current_user.has_role?(role)
      redirect_to root_url, :alert => 'You do not have access to this page'
    end
  end

  def not_authenticated
    redirect_to login_url, :alert => 'You must be logged in to continue'
  end
end
