require 'rails_helper'

RSpec.describe "appointments/edit", type: :view do
  let(:appointment) {
    Appointment.create!(
      date: "MyString",
      time: "MyString",
      paid_amount: 1,
      doctor: nil,
      client: nil
    )
  }

  before(:each) do
    assign(:appointment, appointment)
  end

  it "renders the edit appointment form" do
    render

    assert_select "form[action=?][method=?]", appointment_path(appointment), "post" do

      assert_select "input[name=?]", "appointment[date]"

      assert_select "input[name=?]", "appointment[time]"

      assert_select "input[name=?]", "appointment[paid_amount]"

      assert_select "input[name=?]", "appointment[doctor_id]"

      assert_select "input[name=?]", "appointment[client_id]"
    end
  end
end
