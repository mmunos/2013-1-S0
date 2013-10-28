class Season < ActiveRecord::Base
  belongs_to :serial
  has_many :episodes

  has_many :reviews, as: :reviewable


  validates :number, uniqueness: {scope: :serial_id}, presence: true

	def to_param
	    number
	end

    def self.find(input)
    	find_by(number: input)
    end
end
