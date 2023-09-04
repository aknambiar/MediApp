require 'rails_helper'

RSpec.describe ClientPartialHelper do
  # fixtures :appointments
  before(:all) do
    doc = Doctor.create(name: "Neha", location: "Bangalore")
    app = Appointment.create(date:"01/01/2099",time: "12", doctor_id: doc.id)
    client_params = { email: "mail@test.com", currency_preference: "USD" }
    params = { app_id: app.id }
    @client_helper = ClientPartialHelper.new(client_params, params)
  end

  it "updates the client and the associated appointment" do
    allow(Client).to receive(:update).and_return(true)
    allow(Appointment).to receive(:update).and_return(true)

    success = @client_helper.update

    expect(success).to be_truthy
  end
end
