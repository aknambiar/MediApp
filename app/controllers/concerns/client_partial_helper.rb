class ClientPartialHelper
  attr_reader :client, :appointment

  def initialize(client_params, params)
    @client_params = client_params
    @client = Client.find_or_initialize_by(email: client_params[:email])
    @appointment = Appointment.find(params[:appointment_id])
  end

  def process_appointment
    status = pay_for_appointment && update
    schedule_email if status
    status
  end

  private

  def update
    begin
      Client.transaction do
        @client.update!(@client_params)
        @appointment.update!(update_params)
      end
    rescue ActiveRecord::RecordInvalid
      false
    end
  end

  def pay_for_appointment
    PaymentProcessor.new.pay
  end

  def schedule_email
    MailSchedulerJob.set(wait_until: send_time).perform_later(@appointment.id)
  end

  def update_params
    currency = @client.currency_preference

    { paid_amount: Constants::PRICE,
      client_id: @client.id,
      paid: true,
      exchange_rate: $fixer_client.rates[currency],
      currency: currency }
  end

  def send_time
    if Rails.env.production?
      @appointment.get_datetime.asctime.in_time_zone("Kolkata") + 2.hours
    else
      DateTime.now + 10.seconds
    end
  end
end
