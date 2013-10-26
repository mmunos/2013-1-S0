class EpisodeUser < ActiveRecord::Base
	belongs_to :watched 
	belongs_to :episode
end
