json.array!(@searches) do |search|
  json.extract! search, :keywords, :tags, :info
  json.url search_url(search, format: :json)
end
