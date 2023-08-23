class DateRadioButton < Date
  def radio_text
    day_value = strftime("%a, #{day.ordinalize}")
    day_specifier = today? ? "Today," : (tomorrow? ? "Tomorrow," : " ")
    month_value = strftime("%b")
    { specifier: day_specifier, day: day_value, month: month_value }
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
