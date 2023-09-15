class InvoiceDownloader
  def generate_file(format, appointment_id)
    content = generate_invoice(appointment_id)
    path = "#{Constants::INVOICE_SAVE_PATH}/#{appointment_id}.#{format}"
    send(format, path, content)
    path
  end

  private

  def generate_invoice(appointment_id)
    appointment = Appointment.find(appointment_id)
    currency = appointment.currency
    paid_amount = appointment.paid_amount * appointment.exchange_rate
    { id: appointment.id,
      email: appointment.client.email,
      doctor: appointment.doctor.name,
      location: appointment.doctor.location,
      date: appointment.date,
      time: appointment.time,
      paid_amount: "#{paid_amount} #{currency}" }
  end

  def csv(path, content)
    IO.write(path, content.keys.join(', ')+"\n")
    IO.write(path, content.values.join(', '), mode: 'a')
  end

  def pdf(path, content)
    Prawn::Document.generate(path) do
      text content.keys.join(' ')
      text content.values.join(' ')
    end
  end

  def txt(path,content)
    IO.write(path, content.keys.join(' ')+"\n")
    IO.write(path, content.values.join(' '), mode: 'a')
  end
end