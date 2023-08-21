class ClientPartialHelper
  attr_reader :rates, :client

  def initialize
    @rates = {}
    Constants::ACCEPTED_CURRENCIES.each { |c| @rates[c] = $fixer_client.convert(Constants::PRICE, c) }
    @client = Client.new
  end

  def update_appointment(client, params)
    appointment = Appointment.find(params[:app_id])
    puts client.currency_preference
    update_params = { paid_amount: Constants::PRICE,
                      client_id: client.id,
                      paid: true,
                      exchange_rate: $fixer_client.rates[client.currency_preference] }
    appointment.update(update_params)
  end
end
