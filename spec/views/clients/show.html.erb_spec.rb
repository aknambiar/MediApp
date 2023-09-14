require 'rails_helper'

RSpec.describe "/clients", type: :request do
  let!(:appointment) { create(:appointment) }

  context "when rendering the my appointments partial" do
    before(:each) { get "/clients/#{appointment.client.id}" }

    it "verifies the presence of appointment details" do
      expect(response.body).to match(appointment.doctor.name)
      expect(response.body).to match(appointment.doctor.location)
      expect(response.body).to match("5.00 USD")
    end

    it "verifies the presence of a download button" do
      link = Regexp.escape("/appointments/download?")

      expect(response.body).to match(link)
    end

    it "verifies the presence of a cancel button" do
      tag = /value="delete"/

      expect(response.body).to match(tag)
    end
  end
end