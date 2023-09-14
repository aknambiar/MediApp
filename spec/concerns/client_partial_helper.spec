require 'rails_helper'

RSpec.describe ClientPartialHelper do
  before(:all) do
    @appointment = create(:appointment)
    client_params = { email: "mail@test.com", currency_preference: "USD" }
    params = { appointment_id: @appointment.id }
    @client_helper = ClientPartialHelper.new(client_params, params)
  end

  it "should update the client and the associated appointment" do
    # allow_any_instance_of(Client).to receive(:update).and_return(true)
    # allow_any_instance_of(Appointment).to receive(:update).and_return(true)

    success = @client_helper.update

    expect(success).to be_truthy
  end

  it "should schedule an email for the appointment" do
    expect { @client_helper.schedule_email(@appointment.id) }.to have_enqueued_job(MailSchedulerJob)
  end

  it "should return the date and time" do
    data = @client_helper.get_date_and_time

    expect(data).to eq({ date: "01/01/2099", time: "15" })
  end
end
