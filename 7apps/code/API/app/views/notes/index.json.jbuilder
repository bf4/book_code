json.array!(@notes) do |note|
  json.extract! note, :id, :title, :body, :latitude, :longitude, :created_where
  json.url note_url(note, format: :json)
end
