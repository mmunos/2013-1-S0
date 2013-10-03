class Show < ActiveRecord::Base
	has_many :show_users
	has_many :users, :through => :show_users
end
