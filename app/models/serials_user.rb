class SerialsUser < ActiveRecord::Base
	belongs_to :user
	belongs_to :serial
end
