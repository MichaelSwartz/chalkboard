class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authenticate_owner!
    unless owner == current_user
      deny_and_redirect
    end
  end

  def deny_and_redirect
    flash[:alert] = "Access restricted to competition creator"
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end
end
