class Search < ActiveRecord::Base

  def to_param
    keywords.parameterize("+")
  end

  def self.find(input)
    Search.all.each do |s|
      if s.keywords == input
        return s
      end
    end
    nil
  end

  def shows_by_name
    find_shows[0]
  end

  def movies_by_name
    find_shows[1]
  end

  def serials_by_name
    find_shows[2]
  end

  def shows_by_genre
    results = []
    Search.keywords_list(keywords).each do |keyword|
      Show.all.each do |show|
        if show.genre.downcase.include?(keyword.downcase)
          results << show if results.exclude?(show)
        end
      end
    end
    results
  end

  def episodes_by_name
    results = []
    Search.keywords_list(keywords).each do |keyword|
      Episode.where("name LIKE ?", "#{keyword.downcase}").each do |episode|
        results << episode if results.exclude?(episode)
      end
    end
    results
  end

  def episodes_by_tags
    results = []
    Search.keywords_list(keywords).split(" ").each do |keyword|
      Episode.all.each do |episode|
        if episode.tags.map{|t| t.name}.include?(keyword)
          results << episode if results.exclude?(episode)
        end
      end
    end
    results
  end

  def shows
    shows_by_name | shows_by_genre
  end

  def episodes 
    episodes_by_tags | episodes_by_name
  end

  def results
    shows | episodes
  end

  def self.keywords_list(keywords)
    keywords.split(",").flatten.join(" ").split(" ").join("+").split("+")
  end

def find_season(e)
        season = Season.find_by_id(e)
end

def find_series(e)
        series = Serial.find_by_id(e)
end

  private

  def find_shows
    results = []
    movies = []
    serials = []
    Search.keywords_list(keywords).each do |keyword|
      Show.where("name LIKE ?", "%#{keyword}%").each do |show|
        results << show if results.exclude?(show)
        movies << show if show.is_a?(Movie) and movies.exclude?(show)
        serials << show if show.is_a?(Serial) and serials.exclude?(show)
      end
    end
    [results, movies, serials]
  end
end
