class Movie < Show
	has_many :movie_users, dependent: :destroy

 	has_many :reviews, as: :reviewable, dependent: :destroy
 	has_many :posts, as: :commentable, dependent: :destroy


	def to_param
        [id,name.parameterize].join("-")
    end

    def self.find(input)
    	find_by(id: input.split("-")[0])
    end

end
