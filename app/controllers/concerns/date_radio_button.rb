class DateRadioButton < Date
  def radio_text
    date_in_words
  end

  def radio_value
    strftime('%d/%m/%Y')
  end

  def to_a
    [self.strftime('%d/%m/%Y')]
  end
end
