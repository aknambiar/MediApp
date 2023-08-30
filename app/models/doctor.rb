require 'date'

class Doctor < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_one_attached :avatar

  validates :name, :location, :working_hours, presence: true

  def working_hours_format
    
  end

  def available_slots(date)
    work_slots = working_hours.split(',')
    work_slots.select! { |slot| slot > Time.now.strftime('%k') } if date.to_date.today?
    work_slots - booked_slots(date)
  end

  def booked_slots(date)
    Appointment.where(doctor: id, date: date).map(&:time)
  end

  def weekly_available_slots
    dates = (Date.today..Date.today + Constants::SCHEDULING_RANGE).map { |date| date.strftime('%d/%m/%Y') }
    dates.map { |date| available_slots(date) }
  end
end
