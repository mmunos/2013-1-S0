class ShowWatchlist < ActiveRecord::Base
	belongs_to :show 
	belongs_to :watchlist 
	belongs_to :show, foreign_key: :show_id
	belongs_to :movie, foreign_key: :show_id
	belongs_to :serial, foreign_key: :show_id
end
