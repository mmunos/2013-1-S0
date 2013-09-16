class SerialsUser < ActiveRecord::Base
	belongs_to :user
	belongs_to :serial

	self.primary_key = [:serial_id, :user_id]
end
