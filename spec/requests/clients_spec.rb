require 'rails_helper'

RSpec.describe "/clients", type: :request do
  let!(:appointment) { create(:appointment) }
  let(:valid_attributes) { { email: "mail1@test.com" } }

  describe "GET /new" do
    it "renders a successful response" do
      rates = Constants::ACCEPTED_CURRENCIES.to_h { |c| [c, FixerAPI.new.convert(Constants::PRICE, c)] }
      get new_client_path(appointment_id: appointment.id, client: Client.new, rates: rates)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get client_url(appointment.client.id)

      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Client" do
        expect {
          post clients_url, params: { client: valid_attributes, appointment_id: appointment.id }
        }.to change(Client, :count).by(1)
      end

      it "redirects to the created client" do
        post clients_url, params: { client: valid_attributes, appointment_id: appointment.id }

        expect(response).to redirect_to(appointment)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Client" do
        expect {
          post clients_url, params: { client: { email: "123" }, appointment_id: appointment.id }
        }.to change(Client, :count).by(0)
      end

      it "renders a response with 422 status" do
        post clients_url, params: { client: { email: "123" }, appointment_id: appointment.id }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /login" do
    it "renders a successful response" do
      get login_path

      expect(response).to be_successful
    end
  end

  describe "GET /create_user_session" do
    context "with a valid client email" do
      it "redirects to clients/show" do
        get get_session_path(email: appointment.client.email)

        expect(response).to redirect_to(appointment.client)
      end
    end

    context "with an invalid client email" do
      it "renders clients/login" do
        get get_session_path(email: nil)

        expect(response).to render_template('login')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "POST /create_user_session" do
    context "with a valid client email" do
      it "redirects to clients/show" do
        post session_path, params: { email: appointment.client.email }

        expect(response).to redirect_to(appointment.client)
      end
    end

    context "with an invalid client email" do
      it "renders clients/login" do
        post session_path, params: { email: nil }

        expect(response).to render_template('login')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
