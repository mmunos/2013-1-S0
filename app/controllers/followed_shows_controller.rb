#encoding: utf-8
class FollowedShowsController < ApplicationController
  	skip_before_filter :user_admin, only: [:shows, :serials, :movies]
	

	before_action :set_user, only: [:shows, :serials, :movies]

	def shows
		@shows = @user.shows
		@serials = @user.serials
		@movies = @user.movies
	end

	def serials
		@serials = @user.serials
	end

	def movies
		@movies = @user.movies
	end

	private

	def set_user
		if current_user || session[:user_id]
			@user = current_user || User.find_by(id: session[:user_id])
		end
	end

end
