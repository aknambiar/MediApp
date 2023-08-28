class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :client, optional: true

  validates :date, :time, :doctor_id, presence: true

  def get_datetime
    "#{date} #{time}:00".to_datetime
  end

  def cancel?
    get_datetime - Constants::CANCEL_TIME_LIMIT.minutes < DateTime.now.asctime.in_time_zone("GMT")
  end

  def time_string
    "#{time}:00".to_time.strftime("%l:%M %p")
  end
end
