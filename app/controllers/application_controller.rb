class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  before_filter :authorize
  before_filter :admin
  protect_from_forgery
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  protected
  def authorize
  	unless User.find_by_id(session[:user_id])
  		redirect_to login_path, :notice=> "Please log in"
  	end
  end

  def admin

    if User.find_by_id(session[:user_id])
      @user = User.find_by_id(session[:user_id])
      unless @user.role=='admin'
        redirect_to log_in_path, :notice=>"Access Denied" 
      end
    end
  end



end
