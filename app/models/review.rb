
class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  validates :user, uniqueness: { scope: [:reviewable_type, :reviewable_id], message: "You already left a review!"}, presence: true
  validates :rating, inclusion: {in: [1,2,3,4,5]}
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

  def as_json(options={})
    options[:except] ||= [:user_id, :reviewable_id, :reviewable_type]
    json = super(options)
    json["username"] = self.user.username
    json
  end 
end
