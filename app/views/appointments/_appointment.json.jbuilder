json.extract! appointment, :id, :date, :time, :paid_amount, :doctor_id, :client_id, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
