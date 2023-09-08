require 'rails_helper'

RSpec.describe Client, type: :model do
  # let(:email) { "mail@test.com" }
  let(:client) { create(:client) }

  it "is valid with valid attributes" do
    expect(client).to be_valid
  end

  describe "is invalid when" do
    example "email is not valid" do
      invalid_email = "abc"

      expect { client.update!(email: invalid_email) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    example "currency is not supported" do
      invalid_currency = "ABC"

      expect { client.update!(currency_preference: invalid_currency) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
