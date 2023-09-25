class InvoiceDownloader
  require 'prawn'
  require 'prawn/table'

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
    paid_amount = appointment.amount_in_original_currency
    { # id: appointment.id,
      "Your Email": appointment.client.email,
      "Your Doctor": appointment.doctor.name,
      "Clinic Location": appointment.doctor.location,
      "Appointment Date": appointment.date,
      "Appointment Time": "#{appointment.time}:00",
      "Amount Paid": "#{'%.2f' % [paid_amount]} #{currency}" }
  end

  def csv(path, content)
    IO.write(path, content.keys.join(', ') + "\n")
    IO.write(path, content.values.join(', '), mode: 'a')
  end

  def pdf(path, content)
    Prawn::Document.generate(path) do
      font_size 32
      text "MediApp Invoice", align: :center
      move_down 20

      font_size 18
      text "Your Appointment Details", align: :center
      move_down 20

      font_size 12
      text "Generated for #{content[:email]}", align: :center
      move_down 20

      table_data = content.map { |key, value| [key.to_s, value] }
      table_data.unshift([{ content: 'Description', background_color: '0D6EFD' }, { content: 'Value', background_color: '0D6EFD' }])

      p table_data

      offset = 175
      bounding_box([offset, cursor], width: bounds.width - offset) { table(table_data) }
    end
  end

  def txt(path, content)
    IO.write(path, content.keys.join(', ') + "\n")
    IO.write(path, content.values.join(', '), mode: 'a')
  end
end
