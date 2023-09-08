require 'rails_helper'

RSpec.describe InvoiceDownloader do
  let!(:appointment) { create(:appointment) }

  it 'calls the respective file downloader' do
    allow(InvoiceDownloader).to receive(:generate_invoice).and_return("content")
    allow(InvoiceDownloader).to receive(:csv)
    format = "csv"

    InvoiceDownloader.generate_file(format, appointment.id)

    expect(InvoiceDownloader).to have_received(:csv)
  end

  # it "generates an invoice" do
  #   invoice = InvoiceDownloader.generate_invoice(appointment.id)

  #   expect(invoice).to be_a(Hash)
  #   expect(invoice).to include(:id, :email, :doctor, :location, :date, :time, :paid_amount)
  # end
end