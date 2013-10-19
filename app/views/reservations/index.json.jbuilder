json.array!(@reservations) do |reservation|
  json.extract! reservation, :initial_date, :end_date, :owner_id
  json.url reservation_url(reservation, format: :json)
end
