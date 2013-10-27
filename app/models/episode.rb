class Episode < ActiveRecord::Base
  belongs_to :season

  has_many :episode_taggings, dependent: :destroy
  has_many :tags, through: :episode_taggings

  belongs_to :user_episode_taggings
  has_many :user_tags, through: :user_episode_taggings, source: :tag

  validates :number, uniqueness: {scope: :season_id}, presence: true
  validates :name, presence: true, uniqueness: {scope: :season_id,case_sensitive: false}

  def to_param
	  number
  end

  def self.find(input)
  	find_by(number: input)
  end

  def self.tagged_with(name)
    Tag.find_by_name(name).episodes
  end

  def tags_list
    tags.map(&:name).join(", ")
  end

  def user_tags_list
    user_tags.map(&:name).join(", ")
  end
  
  def update_user_tags(update_tags,episode,user)
    param_tags =[]
    update_tags.split(",").uniq.map do |n|
      param_tags << Tag.find_or_create_by(name: n.strip.downcase)
    end
    new_tags = param_tags - user_tags
    remove_tags = user_tags - param_tags
    new_tags.each do |tag|
      UserEpisodeTagging.create(episode: episode, tag: tag, user: user)
    end
    remove_tags.each do |tag|
      remove_record = UserEpisodeTagging.where(episode: episode, tag:tag, user: user)
      remove_record.each do |o|
        o.destroy
      end
    end
  end

  def update_tags(update_tags,episode)
    param_tags =[]
    update_tags.split(",").uniq.map do |n|
      param_tags << Tag.find_or_create_by(name: n.strip.downcase)
    end
    new_tags = param_tags - tags
    remove_tags = tags - param_tags
    new_tags.each do |tag|
      EpisodeTagging.create(episode: episode, tag: tag)
    end
    remove_tags.each do |tag|
      remove_record = EpisodeTagging.where(episode: episode, tag:tag)
      remove_record.each do |o|
        o.destroy
      end
    end
  end

end
