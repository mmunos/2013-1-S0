class Movie < Show
	require 'net/http'
	has_many :movie_users, dependent: :destroy

	def to_param
        [id,name.parameterize].join("-")
    end

    def self.find(input)
    	find_by(id: input.split("-")[0])
    end

    def self.search_rating(title)
	  	apikey = "c8djpdgrn6wnptcy9ftmkadn";
	  	baseUrl = "http://api.rottentomatoes.com/api/public/v1.0";

	  	moviesSearchUrl = baseUrl + '/movies.json?apikey=' + apikey;

		query = URI.encode(title)
		url = moviesSearchUrl + '&q=' + query
		uri = URI.parse(url)

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = false
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Get.new(uri.request_uri)
		status = JSON.parse(http.request(request).body)
	end





################
end
