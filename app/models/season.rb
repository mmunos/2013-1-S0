class Season < ActiveRecord::Base
  belongs_to :serial
  has_many :episodes, dependent: :destroy

  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :posts, as: :commentable, dependent: :destroy


  validates :number, uniqueness: {scope: :serial_id}, presence: true

	def to_param
	    number
	end

    def self.find(input)
    	find_by(number: input)
    end
end
