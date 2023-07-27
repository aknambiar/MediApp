require 'rails_helper'

RSpec.describe "doctors/index", type: :view do
  before(:each) do
    assign(:doctors, [
      Doctor.create!(
        name: "Name",
        location: "MyText",
        working_hours: 2
      ),
      Doctor.create!(
        name: "Name",
        location: "MyText",
        working_hours: 2
      )
    ])
  end

  it "renders a list of doctors" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
