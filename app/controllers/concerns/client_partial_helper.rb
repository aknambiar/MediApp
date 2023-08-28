class ClientPartialHelper
  attr_reader :date, :time

  def initialize(client_params, params)
    @client_params = client_params
    @client = Client.find_or_initialize_by(email: client_params[:email])
    @appointment = Appointment.find(params[:app_id])

    @update_params = { paid_amount: Constants::PRICE,
                       client_id: @client.id,
                       paid: true,
                       exchange_rate: $fixer_client.rates[@client.currency_preference] }
  end

  def update
    Client.transaction do
      @client.update(@client_params) && @appointment.update(@update_params)
    end
  end

  def schedule_email(appointment_id)
    appointment = Appointment.find(appointment_id)
    send_time = appointment.get_datetime.asctime.in_time_zone("Kolkata") + 2.hours
    # send_time = DateTime.now + 10.seconds
    MailSchedulerJob.set(wait_until: send_time).perform_later(appointment_id)
  end

  def get_date_and_time
    { date: @appointment.date, time: @appointment.time }
  end
end
