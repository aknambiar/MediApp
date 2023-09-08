require 'rails_helper'

RSpec.describe FixerAPI do
  let(:fixer_api) { FixerAPI.new }

  it 'converts an amount to the target currency' do
    amount = 500
    target_currency = 'USD'

    converted_amount = fixer_api.convert(amount, target_currency)

    expect(converted_amount).to be_a(Numeric)
  end
end