class EpisodeTagging < ActiveRecord::Base
  belongs_to :episode
  belongs_to :tag

  validates :tag_id, uniqueness: {scope: :episode_id}
end
