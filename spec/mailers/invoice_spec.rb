require "rails_helper"

RSpec.describe InvoiceMailer, type: :mailer do
  describe "send_invoice" do
    let(:appointment) { create(:appointment) }
    let(:mail) { InvoiceMailer.send_invoice(appointment) }

    it "renders the headers" do
      expect(mail.subject).to eq("Send invoice")
      expect(mail.to).to eq(["mail@test.com"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to be_truthy
    end
  end

end
