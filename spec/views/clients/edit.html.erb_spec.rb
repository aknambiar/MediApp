require 'rails_helper'

RSpec.describe "clients/edit", type: :view do
  let(:client) {
    Client.create!(
      name: "MyString",
      email: "MyString",
      mobile_number: 1,
      address: "MyText"
    )
  }

  before(:each) do
    assign(:client, client)
  end

  it "renders the edit client form" do
    render

    assert_select "form[action=?][method=?]", client_path(client), "post" do

      assert_select "input[name=?]", "client[name]"

      assert_select "input[name=?]", "client[email]"

      assert_select "input[name=?]", "client[mobile_number]"

      assert_select "textarea[name=?]", "client[address]"
    end
  end
end
