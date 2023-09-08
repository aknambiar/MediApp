require 'rails_helper'

RSpec.describe InvoiceDownloader do
  let!(:appointment) { create(:appointment) }
  let(:invoice_downloader) { InvoiceDownloader.new }

  it 'calls the respective file downloader' do
    allow(invoice_downloader).to receive(:generate_invoice).and_return("content")
    allow(invoice_downloader).to receive(:csv)
    format = "csv"

    invoice_downloader.generate_file(format, appointment.id)

    expect(invoice_downloader).to have_received(:csv)
  end

  # it "generates an invoice" do
  #   invoice = InvoiceDownloader.generate_invoice(appointment.id)

  #   expect(invoice).to be_a(Hash)
  #   expect(invoice).to include(:id, :email, :doctor, :location, :date, :time, :paid_amount)
  # end
end