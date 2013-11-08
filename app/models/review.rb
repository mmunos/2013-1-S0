class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  validates :user, uniqueness: { scope: [:reviewable_type, :reviewable_id], message: "You already left a review!"}, presence: true
  validates :content, length: {maximum: 1000}

  def stars
  	stars_array = []

  	rating.to_i.times do 
  		stars_array << "★"
  	end

  	while stars_array.size < 5 do
  		stars_array << "☆"
  	end 

  	stars_array.join("")
  end
end
