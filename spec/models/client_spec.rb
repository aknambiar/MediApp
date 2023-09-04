require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:email) { "testmail123@gmail.com" }

  it "is valid with valid attributes" do
    client = Client.new(email: email)
    expect(client).to be_valid
  end

  describe "is invalid when" do
    it "email is not valid" do
      invalid_email = "abc"
      client = Client.new(email: invalid_email)
      expect(client).not_to be_valid
    end

    it "currency is not supported" do
      invalid_currency = "ABC"
      client = Client.new(email: email, currency_preference: invalid_currency)
      expect(client).not_to be_valid
    end
  end
end
