require 'rails_helper'

RSpec.describe Doctor, type: :model do
  let(:valid_attr) {{name:"Neha", location:"Bangalore", working_hours:"01,02,03"}}

  it "is valid with valid attributes" do
    doctor = Doctor.new(valid_attr)
    expect(doctor).to be_valid
  end

  describe "is invalid when" do
    it "name is not valid" do
      invalid_name = { name: "", location: valid_attr[:location], working_hours: valid_attr[:working_hours] }
      doctor = Doctor.new(invalid_name)
      expect(doctor).not_to be_valid
    end

    it "location is not valid" do
      invalid_location = { name: valid_attr[:name], location: nil, working_hours: valid_attr[:working_hours] }
      doctor = Doctor.new(invalid_location)
      expect(doctor).not_to be_valid
    end

    it "working hours are not valid" do
      invalid_hours = { name: valid_attr[:name], location: valid_attr[:location], working_hours:"1,025,36" }
      doctor = Doctor.new(invalid_hours)
      expect(doctor).not_to be_valid
    end
  end

  it "provides the slots available for a doctor" do
    doctor = Doctor.new(valid_attr)
    date = "01/01/2099"
    slots = doctor.available_slots(date)

    expect(slots).to eq(["01", "02", "03"])
  end

  it "provides the slots available over a period of time" do
    doctor = Doctor.new(valid_attr)
    slots = doctor.available_slots_for_range

    expect(slots.length).to eq(Constants::SCHEDULING_RANGE)
  end
end
