require 'rails_helper'

RSpec.describe MailSchedulerJob, type: :job do
  let(:appointment) { create(:appointment) }

  it "schedules a mail if the appointment exists" do
    expect { MailSchedulerJob.perform_now(appointment.id) }.to have_enqueued_mail(InvoiceMailer)
  end

  it "does not schedule a mail if the appointment is cancelled" do
    expect { MailSchedulerJob.perform_now(nil) }.not_to have_enqueued_mail(InvoiceMailer)
  end
end
