class Search < ActiveRecord::Base
	belongs_to :user

def to_param
    [id,keywords.parameterize].join("+")
end

def shows
  @shows ||= find_shows
end

def tagging
  @episodes ||= find_episodes
	@tags ||= find_tags
end

def episodes
  @episodes ||= find_episodes
  @episodes.each do |e|
    if(@tags.include?(e))
      @episodes.delete(e)
    end
  end
  @episodes
end

def details
	@info ||= find_info
end

def find_season(e)
	season = Season.find_by_id(e)
end

def find_series(e)
	series = Serial.find_by_id(e)
end

private

def find_shows
  Show.all(:conditions => conditions)
end

def find_episodes
  Episode.all(:conditions => keyword_episodes)
end

def find_tags
	tag = []
  Episode.all.each do |e|
  	if(e.tags_list.include?"#{keywords}")
  		tag<<(e)
  	end

  end
  tag
end

def find_info
	show = []
	k = keywords.slice(0,1).capitalize + keywords.slice(1..-1)
  Show.all.each do |e|
  	if(e.genre.include?"#{k}")
  		show<<(e)
  	end
  
  end
  show
end

def keyword_conditions
  ["shows.name LIKE ?", "%#{keywords}%"] unless keywords.blank?
end

def keyword_episodes
  ["episodes.name LIKE ?", "%#{keywords}%"] unless keywords.blank?
end


def conditions
  [conditions_clauses.join(' AND '), *conditions_options]
end

def conditions_clauses
  conditions_parts.map { |condition| condition.first }
end

def conditions_options
  conditions_parts.map { |condition| condition[1..-1] }.flatten
end

def conditions_parts
  private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
end

end
