class User < ActiveRecord::Base
    has_many :show_users
    has_many :shows, through: :show_users
    has_many :serials, through: :show_users
    has_many :movies, through: :show_users


    # has_many :serials_users
    # has_many :serials, through: :serials_users
    # accepts_nested_attributes_for :serials_users, allow_destroy: true

    # has_many :movies_users
    # has_many :movies, through: :movies_users
    # accepts_nested_attributes_for :movies_users, allow_destroy: true

    has_secure_password

    validates :name, presence: true
    validates :username, presence: true, uniqueness: {case_sensitive: false}
    validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, uniqueness: true
    validates :role, inclusion: { in: %w{admin user} }

    # def self.authenticate(email, password)
    #     User.find_by(email: email).try(:authenticate, password)
    # end

    def to_param
        username
    end

    def self.find(input)
        find_by(username: input)
    end
end
