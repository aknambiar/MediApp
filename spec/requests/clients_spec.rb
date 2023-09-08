require 'rails_helper'

RSpec.describe "/clients", type: :request do
  let!(:appointment) { create(:appointment) }
  let(:valid_attributes) { { email: "mail1@test.com" } }

  describe "GET /new" do
    it "renders a successful response" do
      rates = Constants::ACCEPTED_CURRENCIES.to_h { |c| [c, FixerAPI.new.convert(Constants::PRICE, c)] }
      get new_client_path(app_id: appointment.id, client: Client.new, rates: rates)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get client_url(appointment.client)

      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Client" do
        expect {
          post clients_url, params: { client: valid_attributes, app_id: appointment.id }
        }.to change(Client, :count).by(1)
      end

      it "redirects to the created client" do
        post clients_url, params: { client: valid_attributes, app_id: appointment.id }

        expect(response).to redirect_to(appointment)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Client" do
        expect {
          post clients_url, params: { client: { email: "123" }, app_id: appointment.id }
        }.to change(Client, :count).by(0)
      end

      it "renders a response with 422 status" do
        post clients_url, params: { client: { email: "123" }, app_id: appointment.id }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
