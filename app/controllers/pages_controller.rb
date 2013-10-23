class PagesController < ApplicationController
  skip_before_filter :authorize, only: [:index, :no_access]
  skip_before_filter :user_admin, only: [:index, :no_access]

  def index
  end

  def no_access
  end
end
