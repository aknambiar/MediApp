class MailSchedulerJob < ApplicationJob
  queue_as :default

  def perform(appointment_id)
    appointment = Appointment.find_by(id: appointment_id)
    InvoiceMailer.send_invoice(appointment).deliver_later if appointment
  end
end
