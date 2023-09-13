class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all
    date_today = Date.today.strftime('%d/%m/%Y')
    @next_available = @doctors.map { |doctor| doctor.available_slots(date_today).first }
      .map { |time| time ? "#{time}:00".to_time.strftime('%l:%M %p') : "N/A" }
  end
end
