module DoctorsHelper
  def format_time(time)
    time ? "#{time}:00".to_time.strftime('%l:%M %p') : "N/A"
  end
end