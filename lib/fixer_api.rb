class FixerApi
  require 'net/http'
  require 'json'
  include Constants

  def initialize
    @rates = fetch_and_convert_to_inr
  end

  def convert(amount, target_currency)
    amount * @rates[target_currency] # if target_currency in @rates.key
  end

  private

  def fetch_and_convert_to_inr
    rates_in_euro = fetch_rates
    inr = rates_in_euro["INR"]
    rates_in_inr = {}
    ACCEPTED_CURRENCIES.each do |currency|
      rates_in_inr[currency] = rates_in_euro[currency] / inr
    end
    rates_in_inr
  end

  def fetch_rates
    api_key = "bb8b71f880ef7ddb32808b759c7d37ab"
    uri = URI("http://data.fixer.io/api/latest")
    # uri.query = URI.encode_www_form({access_key: api_key, base:"INR"}) # Access Restricted
    uri.query = URI.encode_www_form({ access_key: api_key })

    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)["rates"]
  end
end

# fixer = FixerApi.new
