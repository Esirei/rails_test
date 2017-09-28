class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    # return @current_user if not nil, or @current_user equals
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # return true if current_user returns nonnull @current_user otherwise false
    # !!current_user
    !current_user.nil?
  end

  def require_user
    # unless logged_in?
    unless logged_in?
      flash[:danger] = 'You must be logged in to perform that action'
      redirect_to(root_path)
    end
  end

  def require_same_user(user, msg)
    unless current_user.eql?(user) || current_user.admin?
      flash[:danger] = msg
      redirect_to user_path(current_user)
    end
  end
end
