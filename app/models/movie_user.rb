class MovieUser < ActiveRecord::Base
	belongs_to :watched 
	belongs_to :movie, foreign_key: :show_id
	
end
