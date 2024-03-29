json.array!(@reviews) do |review|
  json.extract! review, :user_id, :rating, :content, :reviewable_id
  json.url review_url(review, format: :json)
end
