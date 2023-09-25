require 'rails_helper'

RSpec.describe ClientPartialHelper do
  before(:each) do
    @appointment = create(:appointment)
    client_params = { email: "mail@test.com", currency_preference: "USD" }
    params = { appointment_id: @appointment.id }
    @client_helper = ClientPartialHelper.new(client_params, params)
  end

  context "on successful payment" do
    it "should update the client and the associated appointment" do
      result = @client_helper.process_appointment

      expect(result).to be_truthy
    end

    it "should schedule an email" do
      expect { @client_helper.process_appointment }.to have_enqueued_job(MailSchedulerJob)
    end
  end

  context "on unsuccessful payment" do
    it "should not update any records" do
      allow_any_instance_of(PaymentProcessor).to receive(:pay).and_return(false)
      allow(@client_helper).to receive(:update)

      @client_helper.process_appointment

      expect(@client_helper).not_to have_received(:update)
    end

    it "should not schedule an email" do
      allow_any_instance_of(PaymentProcessor).to receive(:pay).and_return(false)

      expect { @client_helper.process_appointment }.not_to have_enqueued_job(MailSchedulerJob)
    end
  end
end
