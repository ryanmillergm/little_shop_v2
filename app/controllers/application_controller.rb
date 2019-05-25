class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user,:current_user?, :current_merchant?, :current_admin?, :cart

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def current_merchant?
    current_user && current_user.role == "merchant"
  end

  def current_admin?
    current_user && current_user.role == "admin"
  end

  def current_user?
    current_user && current_user.role == "user"
  end
end
