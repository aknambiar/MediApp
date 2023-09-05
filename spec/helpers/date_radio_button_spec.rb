require 'rails_helper'

RSpec.describe DateRadioButton do
  let(:date_radio_btn) { DateRadioButton.parse("01/01/2099") }
  it "provides a value for radio buttons" do
    expected_value = { date: "1st", day_long: "Thursday", day_short: "Thu", month_long: "January", month_short: "Jan", specifier: " " }

    expect(date_radio_btn.radio_text).to eql expected_value
  end

  it "provides text for radio buttons" do
    expect(date_radio_btn.radio_value).to eql "01/01/2099"
  end

  it "converts the date to an array" do
    expect(date_radio_btn.to_a).to eql ["01/01/2099"]
  end
end
