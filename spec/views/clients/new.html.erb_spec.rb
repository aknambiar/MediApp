require 'rails_helper'

RSpec.describe "/clients", type: :request do
  let!(:appointment) { create(:appointment) }
  let(:rates) { Constants::ACCEPTED_CURRENCIES.to_h { |c| [c, FixerAPI.new.convert(Constants::PRICE, c)] } }
  before(:each) { get new_client_path(appointment_id: appointment.id, rates: rates) }

  it "verifies the presence of an email entry field" do
    email_field = /id="client_email"/
    
    expect(response.body).to match(email_field)
  end

  it "verifies the presence of an currency entry field" do
    tag = "for=\"client_currency_preference_"

    buttons = Constants::ACCEPTED_CURRENCIES.map { |c| tag + c.downcase }

    buttons.each { |btn| expect(response.body).to match(btn) }
  end

  it "verifies the presence of a submit button" do
    button = /type="submit"/

    expect(response.body).to match(button)
  end
end
