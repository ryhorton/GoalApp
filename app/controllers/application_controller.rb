class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :login_user!, :current_user, :logged_in?


  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    @current_user = user
    @current_user.reset_token!
    session[:session_token] = @current_user.session_token
  end

  def logged_in?
    !!current_user
  end

end
