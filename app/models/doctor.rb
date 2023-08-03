class Doctor < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_one_attached :avatar

  def self.next_available_slot(doctor_id)
    doctor = Doctor.find(doctor_id)
    work_slots = doctor.working_hours.split(',')
    puts "\n\n\n #{work_slots} \n\n\n"
    available_hours = work_slots - booked_hours_today(doctor_id)
    available_hours.min
  end

  def self.booked_hours_today(doctor_id)
    date_today = DateTime.now.strftime("%d/%m/%Y")
    all_appointments = Appointment.where(doctor: doctor_id, date: date_today)
    all_appointments.map(&:time) if all_appointments

    return []
  end
end
