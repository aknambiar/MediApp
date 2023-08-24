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

  def self.generate_file(id, format)
    content = generate_invoice(id)
    path = "storage/invoices/#{id}.#{format}"
    self.send(format, path, content)
    IO.binread(path)
  end

  def self.csv(path, content)
    IO.write(path, content.keys.join(', ')+"\n")
    IO.write(path, content.values.join(', '), mode: 'a')
    # send_file(path,
    #           filename: "#{appointment_id}.csv")
  end

  def self.pdf(params)
  end

  def self.txt(params)
  end
end