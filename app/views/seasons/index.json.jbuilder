json.array!(@seasons) do |season|
  json.extract! season, :description, :date, :number, :serial_id
  json.url season_url(season, format: :json)
end
