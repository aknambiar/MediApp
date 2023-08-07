class Doctor < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_one_attached :avatar

  def next_available_slot
    work_slots = working_hours.split(',')

    available_hours = work_slots - booked_hours_today
    available_hours.min
  end

  def booked_hours_today
    date_today = DateTime.now.strftime("%d/%m/%Y")
    all_appointments = Appointment.where(doctor: id, date: date_today)
    return all_appointments.map(&:time) if all_appointments

    return []
  end
end

class Doctor < ApplicationRecord
  def do_stuff
    puts name #works
    puts @name #breaks
  end
end
