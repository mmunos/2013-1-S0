class UserEpisodeTagging < ActiveRecord::Base
  belongs_to :user
  belongs_to :episode
  belongs_to :tag
end
