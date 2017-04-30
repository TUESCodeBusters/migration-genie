json.extract! location, :id, :lat, :lng, :created_at, :updated_at
json.url location_url(location, format: :json)
