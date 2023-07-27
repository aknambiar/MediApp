require 'rails_helper'

RSpec.describe "clients/show", type: :view do
  before(:each) do
    assign(:client, Client.create!(
      name: "Name",
      email: "Email",
      mobile_number: 2,
      address: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
