class PagesController < ApplicationController
  skip_before_filter :authorize, only: [:index, :no_access]
  skip_before_filter :user_admin, only: [:index, :no_access]

  def index
  	if current_user
  		redirect_to my_shows_url
  	end
  end

  def no_access
  end
end
