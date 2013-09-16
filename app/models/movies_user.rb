class MoviesUser < ActiveRecord::Base
	belongs_to :user
	belongs_to :movie

	self.primary_key = [:movie_id, :user_id]

end
