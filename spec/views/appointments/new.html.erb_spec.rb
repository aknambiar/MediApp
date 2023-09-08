require 'rails_helper'

RSpec.describe "/appointments", type: :request do
  let!(:doctor) { create(:doctor) }
  before(:each) { get new_appointment_path(doctor_id: doctor.id) }

  it "verifies the presence of an appointment-form tag" do
    tag = /id="appointment-form"/

    expect(response.body).to match(tag)
  end

  context "when rendering the date picker partial" do
    it "verifies the presence of a date picker carousel" do
      tag = /id="date-picker"/

      expect(response.body).to match(tag)
    end

    it "verifies the presence of buttons in the carousel" do
      tag = /class="carousel-item"/

      expect(response.body).to match(tag)
    end

    it "verifies the presence of time radio buttons" do
      tag = /type="radio"/

      expect(response.body).to match(tag)
    end
    
    it "verifies the presence of a submit button" do
      tag = /type="submit"/

      expect(response.body).to match(tag)
    end
  end
end