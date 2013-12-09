class UserEpisodeTagging < ActiveRecord::Base
  belongs_to :user
  belongs_to :episode
  belongs_to :tag

  validates :tag_id, uniqueness: {scope: [:episode_id, :user_id]}

end
