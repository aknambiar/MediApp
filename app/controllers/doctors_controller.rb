class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all
    # Why do we need to get the date in this format? why not just forward the date object?
    # Keep model clean
    date_today = Date.today.strftime('%d/%m/%Y')
    # Refactor this so that we create a instance method on model method that returns the next available slot for a doctor
    # and move the parsing of the time to the view helpers
    @next_available = @doctors.map { |doctor| doctor.available_slots(date_today).first }
      .map { |time| time ? "#{time}:00".to_time.strftime('%l:%M %p') : "N/A" }
  end
end
