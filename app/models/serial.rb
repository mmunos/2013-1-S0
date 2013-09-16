class Serial < ActiveRecord::Base
	has_many :serials_users
	has_many :users, through: :serials_users
end
