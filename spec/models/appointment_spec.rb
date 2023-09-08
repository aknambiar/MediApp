require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let!(:appointment) { create(:appointment) }
  let(:doctor) { appointment.doctor }

  it "is valid with valid attributes" do
    expect(appointment).to be_valid
  end

  describe "is invalid when" do
    example "date format is invalid" do
      invalid_date = "123/42-ABCD"

      expect { appointment.update!(date: invalid_date) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    example "time format is invalid" do
      invalid_time = "26"

      expect { appointment.update!(time: invalid_time) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    example "date is in the past" do
      invalid_date = "01/01/2001"

      expect { appointment.update!(date: invalid_date) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  it "returns the date and time as a DateTime object" do
    expect(appointment.get_datetime.class).to eql DateTime
  end

  it "returns the time as a string" do
    time = "14"
    appointment.update_columns(time: time)

    expect(appointment.time_string).to eql " 2:00 PM"
  end

  context "when the appointment is in the future" do
    it "indicates that it can be cancelled" do
      expect(appointment.cancel?).to be_truthy
    end
  end

  context "when the appointment is in the past" do
    it "indicates that it cannot be cancelled" do
      past_date = "01/01/2001"
      appointment.update_columns(date: past_date)

      expect(appointment.cancel?).to be_falsy
    end
  end
end
