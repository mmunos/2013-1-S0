class Season < ActiveRecord::Base
  belongs_to :serial
  has_many :episodes

  validates :number, uniqueness: {scope: :serial_id}, presence: true

	def to_param
	    number
	end

    def self.find(input)
    	find_by(number: input)
    end
end
