module UserContentable

	extend ActiveSupport::Concern

	included do
		has_many :reviews, as: :reviewable, dependent: :destroy
 		has_many :posts, as: :commentable, dependent: :destroy
	end

end