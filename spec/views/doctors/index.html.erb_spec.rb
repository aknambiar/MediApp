require 'rails_helper'

RSpec.describe "/doctors", type: :request do
  let!(:doctor) { create(:doctor) }
  before(:each) { get doctors_path }

  describe "when rendering the application layout" do
    context "the MediApp button" do
      it 'should exist' do
        text = /Medi App/

        expect(response.body).to match(text)
      end

      it "redirects to doctors/index" do
        link = /"\/doctors"/

        expect(response.body).to match(link)
      end
    end

    context "the My Appointment button" do
      it 'should exist' do
        text = /My Appointments/

        expect(response.body).to match(text)
      end

      it "redirects to appointments/index" do
        link = /"\/appointments"/
        
        expect(response.body).to match(link)
      end
    end
  end

  context "when rendering doctors/index" do
    it "displays the doctor's details" do
      expect(response.body).to match(doctor.name)
      expect(response.body).to match(doctor.location)
    end

    it 'verifies the presence of a Book Visit button' do
      text = /Book Visit/

      expect(response.body).to match(text)
    end

    it "redirects to appointments/new" do
      link = "/appointments/new?doctor_id=" + doctor.id.to_s

      expect(response.body).to match(Regexp.escape(link))
    end
  end
end
