class Watchlist < ActiveRecord::Base
  belongs_to :user

  has_many :show_watchlists
  has_many :shows, through: :show_watchlists
  has_many :serials, through: :show_watchlists
  has_many :movies, through: :show_watchlists
end
