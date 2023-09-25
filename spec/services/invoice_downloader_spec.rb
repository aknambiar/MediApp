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
end