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
      email: appointment.client.email,
      doctor: appointment.doctor.name,
      location: appointment.doctor.location,
      date: appointment.date,
      time: "#{appointment.time}:00",
      paid_amount: "#{'%.2f' % [paid_amount]} #{currency}" }
  end

  def csv(path, content)
    IO.write(path, "Your Email, Your Doctor, Clinic Location, Appointment Date, Appointment Time, Amount Paid")
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

      table_data = [
        [{ content: 'Description', background_color: '0D6EFD' }, { content: 'Value', background_color: '0D6EFD' }],
        ['Doctor', content[:doctor]],
        ['Clinic Location', content[:location]],
        ['Appointment Date', content[:date]],
        ['Appointment Time', content[:time]],
        ['Amount Paid', content[:paid_amount]]
      ]

      offset = 175
      bounding_box([offset, cursor], width: bounds.width - offset) { table(table_data) }
    end
  end

  def txt(path, content)
    IO.write(path, "Your Email: #{content[:email]}")
    IO.write(path, "\nYour Doctor: #{content[:doctor]}", mode: 'a')
    IO.write(path, "\nClinic Location: #{content[:location]}", mode: 'a')
    IO.write(path, "\nAppointment Date: #{content[:date]}", mode: 'a')
    IO.write(path, "\nAppointment Time: #{content[:time]}", mode: 'a')
    IO.write(path, "\nAmount Paid: #{content[:paid_amount]}", mode: 'a')
  end
end
