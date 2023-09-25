require 'rails_helper'

RSpec.describe DoctorsHelper do

  it "should convert a time slot to 00:00 AM/PM format" do
    time_slot = 12
    expect(format_time(time_slot)).to eql "12:00 PM"
  end

  it "should return N/A if an invalid time is provided" do
    time_slot = nil
    expect(format_time(time_slot)).to eql "N/A"
  end
end
