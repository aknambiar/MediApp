require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/appointments", type: :request do
  # before(:all) { @doctor = Doctor.create!(name: 'Neha Kakkar', location: 'Mumbai') }
  let(:doctor) { create(:doctor) }
  let(:appointment) { create(:appointment) }
  let(:valid_attributes) {{ date: "01/01/2099", time: "12", doctor_id: doctor.id }}
  let(:invalid_attributes) {{ date: "021/01/209", time: "36", doctor_id: doctor.id }}

  # let(:valid_attributes) {{
  #   date: (DateTime.now + 2.hours).strftime("%d-%m-%Y"),
  #   time: (DateTime.now + 2.hours).strftime("%H"),
  #   doctor_id: @doctor.id
  # }}

  # let(:invalid_attributes) {
  #   skip("Add a hash of attributes invalid for your model")
  # }

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
      get new_appointment_url(doctor_id: doctor.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Appointment" do
        expect {
          post appointments_url, params: { appointment: valid_attributes }
        }.to change(Appointment, :count).by(1)
      end

      it "redirects to the client form" do
        post appointments_url, params: { appointment: valid_attributes }
        expect(response).to redirect_to(new_client_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Appointment" do
        expect {
          post appointments_url, params: { appointment: invalid_attributes }
        }.to change(Appointment, :count).by(0)
      end

      it "redirects back to the appointments form with errors" do
        post appointments_url, params: { appointment: invalid_attributes }

        expect(response).to redirect_to(new_appointment_path)
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested appointment" do
      appointment = create :appointment

      expect {
        delete appointment_url(appointment)
      }.to change(Appointment, :count).by(-1)
    end

    it "redirects to the appointments list" do
      delete appointment_url(appointment)
      expect(response).to redirect_to(appointments_url)
    end
  end
end
