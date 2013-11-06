class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  validates :user, uniqueness: { scope: [:reviewable_type, :reviewable_id], message: "You already left a review!"}, presence: true

end
