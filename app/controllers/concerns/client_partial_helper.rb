class ClientPartialHelper
  attr_reader :client, :appointment

  def initialize(client_params, params)
    @client_params = client_params
    @client = Client.find_or_initialize_by(email: client_params[:email])
    @appointment = Appointment.find(params[:appointment_id])
  end

  def update
    begin
      Client.transaction do
        @client.update!(@client_params)
        @appointment.update!(update_params)
      end
    rescue ActiveRecord::RecordInvalid
      return false
    end
  end

  def schedule_email
    # send_time = appointment.get_datetime.asctime.in_time_zone("Kolkata") + 2.hours
    send_time = DateTime.now + 10.seconds
    MailSchedulerJob.set(wait_until: send_time).perform_later(@appointment.id)
  end

  private 

  def update_params
    # Do we still need to store the currency preference in the Client model?
    currency = @client.currency_preference

    { paid_amount: Constants::PRICE,
      client_id: @client.id,
      paid: true,
      exchange_rate: $fixer_client.rates[currency],
      currency: currency }
  end
end
