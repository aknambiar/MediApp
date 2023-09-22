class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :client, optional: true

  validates :date, :time, :doctor_id, presence: true
  validate :date_format, :time_format, :appointment_not_in_the_past

  def get_datetime
    "#{date} #{time}:00".to_datetime
  end

  def cancel?
    get_datetime - Constants::CANCEL_TIME_LIMIT.minutes > DateTime.now.asctime.in_time_zone("GMT")
  end

  def time_string
    "#{time}:00".to_time.strftime("%l:%M %p")
  end

  def amount_in_original_currency
    paid_amount * exchange_rate
  end

  private

  def date_format
    errors.add(:date, I18n.t('models.errors.invalid_date')) unless Date.safe_parse(date)
  end

  def time_format
    errors.add(:time, I18n.t('models.errors.invalid_time')) unless time.to_i.between?(1, 24)
  end

  def appointment_not_in_the_past
    if Date.safe_parse(date) && time.to_i.between?(1, 24)
      errors.add(:base,I18n.t('models.errors.appointment_past')) if DateTime.parse("#{date} #{time}:00").asctime.in_time_zone("Kolkata").past?
    end
  end
end
