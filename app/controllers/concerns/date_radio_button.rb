class DateRadioButton < Date
  def radio_text
    day_value = strftime("%a, #{day.ordinalize}")
    day_value = "Today, " + day_value if today?
    day_value = "Tomorrow, " + day_value if tomorrow?
    month_value = strftime("%b")
    { day: day_value, month: month_value }
  end

  def radio_value
    strftime('%d/%m/%Y')
  end

  def tomorrow?
    self == Date.today + 1
  end

  def to_a
    [self.strftime('%d/%m/%Y')]
  end
end
