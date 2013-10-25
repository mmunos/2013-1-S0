json.array!(@watchlists) do |watchlist|
  json.extract! watchlist, :user_id
  json.url watchlist_url(watchlist, format: :json)
end
