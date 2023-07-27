require 'rails_helper'

RSpec.describe "doctors/edit", type: :view do
  let(:doctor) {
    Doctor.create!(
      name: "MyString",
      location: "MyText",
      working_hours: 1
    )
  }

  before(:each) do
    assign(:doctor, doctor)
  end

  it "renders the edit doctor form" do
    render

    assert_select "form[action=?][method=?]", doctor_path(doctor), "post" do

      assert_select "input[name=?]", "doctor[name]"

      assert_select "textarea[name=?]", "doctor[location]"

      assert_select "input[name=?]", "doctor[working_hours]"
    end
  end
end
