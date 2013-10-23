class Episode < ActiveRecord::Base
  belongs_to :season


  validates :number, uniqueness: {scope: :season_id}, presence: true
  validates :name, presence: true, uniqueness: {scope: :season_id,case_sensitive: false}

  def to_param
	number
  end

  def self.find(input)
  	find_by(number: input)
  end
end
