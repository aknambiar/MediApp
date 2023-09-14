class InvoiceDownloader
  # here using just the variable id is confusing, can we use more explicit names like appointment_id?
  # You can make that change all places in this file
  def generate_file(format, id)
    content = generate_invoice(id)
    path = "#{Constants::INVOICE_SAVE_PATH}/#{id}.#{format}"
    send(format, path, content)
    path
  end

  private

  def generate_invoice(id)
    appointment = Appointment.find(id)
    currency = appointment.currency
    # We should not use the fixer client here, we should use the exchange rate stored in the appointment
    paid_amount = $fixer_client.convert(appointment.paid_amount, currency)
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