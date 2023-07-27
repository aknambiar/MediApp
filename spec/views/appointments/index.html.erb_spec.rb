require 'rails_helper'

RSpec.describe "appointments/index", type: :view do
  before(:each) do
    assign(:appointments, [
      Appointment.create!(
        date: "Date",
        time: "Time",
        paid_amount: 2,
        doctor: nil,
        client: nil
      ),
      Appointment.create!(
        date: "Date",
        time: "Time",
        paid_amount: 2,
        doctor: nil,
        client: nil
      )
    ])
  end

  it "renders a list of appointments" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Date".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Time".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
