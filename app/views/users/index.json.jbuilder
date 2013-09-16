json.array!(@users) do |user|
  json.extract! user, :name, :username, :email, :role, :score
  json.url user_url(user, format: :json)
end
