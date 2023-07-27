json.extract! doctor, :id, :name, :location, :working_hours, :created_at, :updated_at
json.url doctor_url(doctor, format: :json)
