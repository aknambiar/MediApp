module InvoiceDownloader
  def self.generate_invoice(id)
    appointment = Appointment.find(id)
    { id: appointment.id,
      email: appointment.client.email,
      doctor: appointment.doctor.name,
      location: appointment.doctor.location,
      date: appointment.date,
      time: appointment.time,
      paid_amount: appointment.paid_amount }
  end

  def self.generate_file(format, id)
    content = generate_invoice(id)
    path = "storage/invoices/#{id}.#{format}"
    self.send(format, path, content)
    path
  end

  def self.csv(path, content)
    IO.write(path, content.keys.join(', ')+"\n")
    IO.write(path, content.values.join(', '), mode: 'a')
    # send_file(path,
    #           filename: "#{appointment_id}.csv")
  end

  def self.pdf(path, content)
    Prawn::Document.generate(path) do
      text content.keys.join(' ')
      text content.values.join(' ')
    end
  end

  def self.txt(path,content)
    IO.write(path, content.keys.join(' ')+"\n")
    IO.write(path, content.values.join(' '), mode: 'a')
  end
end