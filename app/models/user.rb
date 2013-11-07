class User < ActiveRecord::Base
    has_many :show_users, dependent: :destroy
    has_many :shows, through: :show_users
    has_many :serials, through: :show_users
    has_many :movies, through: :show_users

    has_one :watchlist, dependent: :destroy
    has_one :watched, dependent: :destroy
    
    before_create :build_default_watched
    before_create :build_default_watchlist
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


    def to_param
        username
    end

    def self.find(input)
        find_by(username: input)
    end

    def gravatar_url(size)
        gravatar_hash = Digest::MD5.hexdigest(email.downcase.strip)
        gravatar_url = "http://www.gravatar.com/avatar/#{gravatar_hash}?s=#{size}&d=mm"
    end

    private

    def build_default_watchlist
        build_watchlist
    end

        def build_default_watched
        build_watched
    end
end
