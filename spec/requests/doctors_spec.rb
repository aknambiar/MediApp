require 'rails_helper'

RSpec.describe "/doctors", type: :request do
  before(:each) { create(:doctor) }

  describe "GET /index" do
    it "renders a successful response" do
      get doctors_path

      expect(response).to render_template(:index)
    end
  end
end
