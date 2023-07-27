require 'rails_helper'

RSpec.describe "doctors/new", type: :view do
  before(:each) do
    assign(:doctor, Doctor.new(
      name: "MyString",
      location: "MyText",
      working_hours: 1
    ))
  end

  it "renders new doctor form" do
    render

    assert_select "form[action=?][method=?]", doctors_path, "post" do

      assert_select "input[name=?]", "doctor[name]"

      assert_select "textarea[name=?]", "doctor[location]"

      assert_select "input[name=?]", "doctor[working_hours]"
    end
  end
end
