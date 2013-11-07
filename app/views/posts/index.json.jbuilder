json.array!(@posts) do |post|
  json.extract! post, :user_id, :content, :commentable_id
  json.url post_url(post, format: :json)
end
