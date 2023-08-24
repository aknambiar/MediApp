class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :client, optional: true

  def get_datetime
    "#{date} #{time}:00".to_datetime
  end

  def past?
    get_datetime < DateTime.now
  end
end
