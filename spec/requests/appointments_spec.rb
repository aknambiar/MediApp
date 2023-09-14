require 'rails_helper'

RSpec.describe "/appointments", type: :request do
  let!(:appointment) { create(:appointment) }
  let(:valid_attributes) {{ date: "01/01/2099", time: "12", doctor_id: appointment.doctor.id }}
  let(:invalid_attributes) {{ date: "021/01/209", time: "36", doctor_id: appointment.doctor.id }}

  describe "GET /index" do
    it "renders a successful response" do
      get appointments_url

      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get appointment_url(appointment)

      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_appointment_url(doctor_id: appointment.doctor.id)

      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new appointment" do
        expect {
          post appointments_url, params: { appointment: valid_attributes }
        }.to change(Appointment, :count).by(1)
      end

      it "renders clients/new" do
        target = Regexp.new(Regexp.escape(new_client_path))
        post appointments_url, params: { appointment: valid_attributes }
        
        expect(response).to redirect_to target
      end
    end

    context "with invalid parameters" do
      it "does not create a new appointment" do
        expect {
          post appointments_url, params: { appointment: invalid_attributes }
        }.to change(Appointment, :count).by(0)
      end

      it "redirects to appointments/new with errors" do
        post appointments_url, params: { appointment: invalid_attributes }

        expect(response).to redirect_to(new_appointment_path)
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested appointment" do
      expect {
        delete appointment_url(appointment)
      }.to change(Appointment, :count).by(-1)
    end

    it "redirects to appointments/list" do
      delete appointment_url(appointment)

      expect(response).to redirect_to(appointments_url)
    end
  end

  describe "POST /list" do
    context "with valid parameters" do
      it "redirects to client/show" do
        post list_appointment_path, params: { email: appointment.client.email }

        expect(response).to redirect_to(client_path(id: appointment.client.id))
      end
    end

    context "with invalid parameters" do
      it "redirects to appointments/index with errors" do
        post list_appointment_path, params: { email: nil }

        expect(response).to render_template(:index)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /download" do
    context "for supported file types" do
      it 'should send the file as an attachment' do
        get download_appointment_path(id: appointment.id, format: "csv")

        expect(response.headers["Content-Disposition"]).to include("attachment")
        expect(response.headers["Content-Type"]).to eq("text/csv")
        expect(response).to have_http_status(:success)
      end
    end
  end
end
