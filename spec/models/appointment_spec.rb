require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:doctor) {Doctor.create!(name:"TestDoc", location:"Bangalore", working_hours:"01,02,03")}
  let(:valid_attr) {{ date: Date.today.strftime('%d/%m/%Y'), time: (Time.now + 2.hours).strftime('%k'), doctor_id: doctor }}

  it "is valid with valid attributes" do
    appointment = Appointment.new(valid_attr)
    expect(appointment).to be_valid
  end
end
