require 'rails_helper'

RSpec.describe Doctor, type: :model do
  let(:doctor) { create(:doctor) }

  it "is valid with valid attributes" do
    expect(doctor).to be_valid
  end

  describe "is invalid when" do
    example "name is not valid" do
      invalid_name = ""

      expect { doctor.update!(name: invalid_name) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    example "location is not valid" do
      invalid_location = nil

      expect { doctor.update!(location: invalid_location) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    example "working hours are not valid" do
      invalid_hours = "1,025,36"

      expect { doctor.update!(working_hours: invalid_hours) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  it "should provide the slots available for a doctor" do
    date = "01/01/2099".to_date
    slots = doctor.available_slots(date)

    expect(slots).to eq(["15", "16", "17"])
  end

  it "should provide the slots available over a period of time" do
    slots = doctor.available_slots_for_range

    expect(slots.length).to eq(Constants::SCHEDULING_RANGE)
  end
end
