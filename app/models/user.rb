class User < ActiveRecord::Base
	has_many :serials_users
	has_many :serials, through: :serials_users
	accepts_nested_attributes_for :serials_users, allow_destroy: true
end
