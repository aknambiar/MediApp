require 'rails_helper'

RSpec.describe "appointments/show", type: :view do
  before(:each) do
    assign(:appointment, Appointment.create!(
      date: "Date",
      time: "Time",
      paid_amount: 2,
      doctor: nil,
      client: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Date/)
    expect(rendered).to match(/Time/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
