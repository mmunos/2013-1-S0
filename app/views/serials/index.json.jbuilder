json.array!(@serials) do |serial|
  json.extract! serial, :name, :date, :genre, :description
  json.url serial_url(serial, format: :json)
end
