class Date
  def date_in_words
    date_with_suffix = strftime("#{day.ordinalize}")

    day_specifier = today? ? "Today," : (tomorrow? ? "Tomorrow," : " ")
    day_short = strftime("%a")
    day_long = strftime("%A")

    month_short = strftime("%b")
    month_long = strftime("%B")

    { date: date_with_suffix, specifier: day_specifier, day_long: day_long, day_short: day_short, month_short: month_short, month_long: month_long }
  end

  def tomorrow?
    self == Date.today + 1
  end

  def self.safe_parse(value, default = nil)
    Date.parse(value.to_s)
  rescue ArgumentError
    default
  end
end
