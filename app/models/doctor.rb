require 'date'

class Doctor < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_one_attached :avatar

  validates :name, :location, :working_hours, presence: true
  validate :working_hours_format

  def working_hours_format
    errors.add(:working_hours, "Invalid format for Working Hours") unless working_hours =~ /^(0[1-9]|1[0-9]|2[0-4])(,(0[1-9]|1[0-9]|2[0-4]))*$/
  end

  def available_slots(date)
    work_slots = working_hours.split(',')
    work_slots.select! { |slot| slot > Time.now.strftime('%k') } if date.to_date.today?
    work_slots - booked_slots(date)
  end

  def available_slots_for_range
    dates = (Date.today...Date.today + Constants::SCHEDULING_RANGE).map { |date| date.strftime('%d/%m/%Y') }
    dates.map { |date| available_slots(date) }
  end

  private

  def booked_slots(date)
    Appointment.where(doctor: id, date: date).map(&:time)
  end
end
