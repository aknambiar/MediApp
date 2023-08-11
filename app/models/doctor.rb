require 'date'

class Doctor < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_one_attached :avatar

  def available_slots(date)
    work_slots = working_hours.split(',')
    work_slots - booked_slots(date)
  end

  def booked_slots(date)
    Appointment.where(doctor: id, date: date).map(&:time)
  end

  def weekly_available_slots
    dates = (Date.today..Date.today + 7).map { |date| date.strftime('%d/%m/%Y') }
    dates.map { |date| available_slots(date) }
  end
end