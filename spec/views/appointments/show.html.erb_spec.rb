require 'rails_helper'

RSpec.describe "/appointments", type: :request do
  let!(:appointment) { create(:appointment) }
  before(:each) { get appointment_path(appointment.id) }

  # it "verifies the presence of an appointment-form tag" do
  #   tag = /id="appointment-form"/
  #   expect(response.body).to match(tag)
  # end

  context "when rendering the success partial" do
    it "verifies the presence of countdown fields" do
      tag = 'id='

      fields = Constants::COUNTDOWN_FIELDS.map { |c| tag + c }

      fields.each { |field| expect(response.body).to match(field) }
    end

    it "verifies the presence of a My Appointments button" do
      link = /href="\/clients\/login"/

      expect(response.body).to match(link)
    end
  end
end