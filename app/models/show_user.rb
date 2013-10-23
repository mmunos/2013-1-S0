class ShowUser < ActiveRecord::Base
	belongs_to :user
	belongs_to :show, foreign_key: :show_id
	belongs_to :movie, foreign_key: :show_id
	belongs_to :serial, foreign_key: :show_id
end
