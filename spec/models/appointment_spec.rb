require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:doctor) { create(:doctor) }
  let(:valid_attr) {{ date: Date.tomorrow.strftime('%d/%m/%Y'), time: "12", doctor_id: doctor.id }}
  let(:appointment) { Appointment.new(valid_attr) }

  it "is valid with valid attributes" do
    expect(appointment).to be_valid
  end

  describe "is invalid when" do
    it "has an incorrect date format" do
      valid_attr[:date] = "123/42-ABCD"

      appointment = Appointment.new(valid_attr)

      expect(appointment).not_to be_valid
    end

    it "has an incorrect time format" do
      valid_attr[:time] = "26"

      appointment = Appointment.new(valid_attr)

      expect(appointment).not_to be_valid
    end

    example "date is in the past" do
      valid_attr[:date] = "01/01/2001"

      appointment = Appointment.new(valid_attr)

      expect(appointment).not_to be_valid
    end
  end

  it "returns the date and time as a DateTime object" do
    expect(appointment.get_datetime.class).to eql DateTime
  end

  it "returns the time as a string" do
    expect(appointment.time_string).to eql "12:00 PM"
  end

  context "When the appointment is in the future" do
    it "indicates that it can be cancelled" do
      expect(appointment.cancel?).to be_truthy
    end
  end

  context "When the appointment is in the past" do
    it "indicates that it cannot be cancelled" do
      valid_attr[:date] = "01/01/2001"

      appointment = Appointment.new(valid_attr)

      expect(appointment.cancel?).to be_falsy
    end
  end
end
