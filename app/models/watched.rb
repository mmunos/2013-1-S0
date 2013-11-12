class Watched < ActiveRecord::Base
	belongs_to :user

	has_many :episode_users
	has_many :movie_users
	has_many :episodes, through: :episode_users
	has_many :movies, through: :movie_users


def next_episode(watched,season)
	 episodes=0
     episode=nil
     ep=nil
     season.episodes.all.each do |e|
            	if watched.episodes.sort {|a,b| a.season_id <=> b.season_id}.include?(e)
            		episodes=episodes+1
            		episode=e
            	end
            	if not episode.nil? and e.number==episode.number+1
            		ep=e
            	end

     end
          set_episode(episode)
          set_episodes(episodes)
          ep
end

def set_episode(episode)
	@episode = episode
end


def get_episode()
	@episode
	
end

def set_episodes(episodes)
	@episodes = episodes
end


def get_episodes()
	@episodes
	
end

end
