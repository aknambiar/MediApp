class FixerAPI
  require 'net/http'
  require 'json'
  attr_reader :rates, :standard_prices

  def initialize
    @rates = fetch_and_convert_to_inr
    @standard_prices = Constants::ACCEPTED_CURRENCIES.to_h { |c| [c, convert(Constants::PRICE, c)] }
  end

  def convert(amount, target_currency)
    amount * @rates[target_currency] # if target_currency in @rates.key
  end

  private

  def fetch_and_convert_to_inr
    rates_in_euro = fetch_rates
    inr = rates_in_euro["INR"]
    rates_in_inr = {}
    Constants::ACCEPTED_CURRENCIES.each do |currency|
      rates_in_inr[currency] = rates_in_euro[currency] / inr
    end
    rates_in_inr
  end

  def fetch_rates
    api_key = Rails.application.credentials.fixer.api_key
    uri = URI("http://data.fixer.io/api/latest")
    uri.query = URI.encode_www_form({ access_key: api_key })

    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)["rates"]
  end
end
