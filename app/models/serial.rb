class Serial < Show
	include UserContentable
	
	has_many :seasons, dependent: :destroy

	def to_param
        [id,name.parameterize].join("-")
    end

    def self.find(input)
    	find_by(id: input.split("-")[0])
    end

	def self.search_poster(title)
		  	apikey = "49af96950b5c6d76b85aa58a56d38145";
		  	baseUrl = "http://api.trakt.tv/search";

		  	moviesSearchUrl = baseUrl + '/shows.json/' + apikey;

			query = URI.encode(title)
			url = moviesSearchUrl + '?query=' + query
			uri = URI.parse(url)

			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			request = Net::HTTP::Get.new(uri.request_uri)
			status = JSON.parse(http.request(request).body)
	end


end
