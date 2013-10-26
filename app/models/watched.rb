class Watched < ActiveRecord::Base
	belongs_to :user

	has_many :episode_users
	has_many :movie_users
	has_many :episodes, through: :episode_users
	has_many :movies, through: :movie_users

end
