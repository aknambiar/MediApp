require 'rails_helper'

RSpec.describe "appointments/new", type: :view do
  before(:each) do
    assign(:appointment, Appointment.new(
      date: "MyString",
      time: "MyString",
      paid_amount: 1,
      doctor: nil,
      client: nil
    ))
  end

  it "renders new appointment form" do
    render

    assert_select "form[action=?][method=?]", appointments_path, "post" do

      assert_select "input[name=?]", "appointment[date]"

      assert_select "input[name=?]", "appointment[time]"

      assert_select "input[name=?]", "appointment[paid_amount]"

      assert_select "input[name=?]", "appointment[doctor_id]"

      assert_select "input[name=?]", "appointment[client_id]"
    end
  end
end