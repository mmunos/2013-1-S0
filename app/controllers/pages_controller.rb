class PagesController < ApplicationController
  skip_before_filter :authorize, :only => [:index]
  skip_before_filter :user_admin, :only => [:index]

  def index
  end
end
