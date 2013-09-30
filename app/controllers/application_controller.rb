class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  before_filter :authorize
  protect_from_forgery
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

<<<<<<< HEAD
  protected
  def authorize
  	unless User.find_by_id(session[:user_id])
  		redirect_to login_url, :notice=> "Please log in"
  	end
  end


=======
>>>>>>> 5ad609f9443fadfb02e854758e40c7bf469360a8
end
