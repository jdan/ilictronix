class ApplicationController < ActionController::Base
  protect_from_forgery

  def writers_only
    unless current_user && current_user.has_role?(:writer)
      redirect_to root_url, :alert => 'You do not have access to this page'
    end
  end

  def admin_only
    unless current_user && current_user.has_role?(:admin)
      redirect_to root_url, :alert => 'You do not have access to this page'
    end
  end

  def god_only
    unless current_user && current_user.has_role?(:god)
      redirect_to root_url, :alert => 'You do not have access to this page'
    end
  end

  private
  def not_authenticated
    redirect_to login_url, :alert => 'You must be logged in to continue'
  end
end
