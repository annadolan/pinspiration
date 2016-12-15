class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  before_action :authorize!

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize!
    unless authorized?
      redirect_to root_url
      flash[:danger] = "You are not authorized to view that page."
    end
  end

  def authorized?
    PermissionsService.new(current_user, params[:controller], params[:action]).allow?
  end

end
