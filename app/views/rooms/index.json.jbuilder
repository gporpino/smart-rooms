json.array!(@rooms) do |room|
  json.extract! room, :owner_id
  json.url room_url(room, format: :json)
end
