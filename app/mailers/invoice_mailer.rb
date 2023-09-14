class InvoiceMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invoice_mailer.send_invoice.subject
  #
  def send_invoice(appointment)
    @appointment = appointment
    currency = appointment.currency
    @paid_amount = "#{$fixer_client.convert(appointment.paid_amount, currency)} #{currency}"

    mail to: @appointment.client.email
  end
end
