class PagesController < ApplicationController
  skip_before_filter :authorize, :only => [:index]
  skip_before_filter :admin, :only => [:index]

  def index
  end
end
