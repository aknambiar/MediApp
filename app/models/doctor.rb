require 'date'

class Doctor < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_one_attached :avatar

  validates :name, :location, :working_hours, presence: true
  validate :working_hours_format

  def available_slots(date)
    work_slots = working_hours.split(',')
    work_slots.select! { |slot| slot > Time.now.strftime('%k') } if date.today?
    work_slots - booked_slots(date)
  end

  def available_slots_for_range
    dates = (Date.today...Date.today + Constants::SCHEDULING_RANGE).map { |date| available_slots(date) }
    (DateRadioButton.today...DateRadioButton.today + Constants::SCHEDULING_RANGE).zip(dates).to_h.reject { |_date, slot| slot.empty? if slot }
  end

  def next_available
    available_slots(Date.today).first
  end

  private

  def booked_slots(date)
    appointments.where(date: date.strftime('%d/%m/%Y')).map(&:time)
  end

  def working_hours_format
    errors.add(:working_hours, I18n.t('models.errors.invalid_hours')) unless Constants::WORKING_HOURS_REGEXP.match(working_hours)
  end
end
