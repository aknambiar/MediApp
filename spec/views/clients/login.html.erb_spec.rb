require 'rails_helper'

RSpec.describe "/clients", type: :request do
  before(:each) { get login_clients_path }

  it "verifies the presence of an email entry field" do
    email_field = /type="email"/

    expect(response.body).to match(email_field)
  end
  
  it "verifies the presence of a submit button" do
    button = /type="submit"/

    expect(response.body).to match(button)
  end
end
