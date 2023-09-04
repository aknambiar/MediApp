require "rails_helper"

RSpec.describe InvoiceMailer, type: :mailer do
  describe "send_invoice" do
    let(:mail) { InvoiceMailer.send_invoice(Appointment.all.first) }

    it "renders the headers" do
      expect(mail.subject).to eq("Send invoice")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      appointment = Appointment.all.first
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
