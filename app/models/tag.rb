class Tag < ActiveRecord::Base
	validate :name, uniqueness: { case_sensitive: false}

	has_many :user_episode_taggings
	has_many :episode_taggings
end
