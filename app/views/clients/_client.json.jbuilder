json.extract! client, :id, :name, :email, :mobile_number, :address, :created_at, :updated_at
json.url client_url(client, format: :json)
