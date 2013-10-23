json.array!(@episodes) do |episode|
  json.extract! episode, :name, :description, :date, :number, :write, :director, :duration, :season_id
  json.url episode_url(episode, format: :json)
end
