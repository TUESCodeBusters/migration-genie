json.extract! sighting, :id, :created_at, :updated_at
json.url sighting_url(sighting, format: :json)
