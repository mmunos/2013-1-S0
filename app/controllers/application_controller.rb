class ApplicationController < ActionController::Base  
  include ApplicationHelper
  attr_reader :array_parents

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_admin?


  before_filter :authorize
  before_filter :user_admin
  before_filter :set_parent
  protect_from_forgery
  
  def set_parent
    if params[:serial_id]
      serial = Serial.find(params[:serial_id])
      if (params[:season_id] || params[:controller]=="seasons")
        season_number = (params[:controller] == "seasons")? params[:id]: params[:season_id];
        season = serial.seasons.find_by(number: season_number)
      end

      if (params[:episode_id] || params[:controller]=="episodes")
        episode_number = (params[:controller] == "episodes")? params[:id]: params[:episode_id];
        episode = season.episodes.find_by(number: episode_number)
      end
    elsif params[:movie_id]
      movie = Movie.find(params[:movie_id])
    else 
      show = Serial.find(params[:id]) if params[:controller] == "serials" && params[:id]
      show = Movie.find(params[:id]) if params[:controller] == "movies" && params[:id]
    end
    parents = Array.new
    models = [show, movie, serial, season, episode]
    models.each do |model|
      parents << model if model
    end

    @parent = parents[-1]
    @array_parent = parents
  end

  private
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  protected

  def authorize
  	unless User.find_by_id(session[:user_id])
  		redirect_to login_path, notice: "Please log in"
  	end
  end

  def user_admin
    if User.find_by_id(session[:user_id])
      @user = User.find_by_id(session[:user_id])
      unless @user.role == 'admin'
        redirect_to access_denied_path, notice: "Access Denied" 
      end
    end
  end

  def user_admin?(user)
    if user
      user.role == "admin"
    end
  end




end
