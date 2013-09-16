json.array!(@movies) do |movie|
  json.extract! movie, :name, :date, :director, :genre, :duration, :description
  json.url movie_url(movie, format: :json)
end
