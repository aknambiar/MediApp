class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit update destroy ]

  # GET /appointments or /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @doctor = Doctor.find(params[:doctor_id])
    @slots = @doctor.available_slots_for_range
    @dates = (DateRadioButton.today...DateRadioButton.today + Constants::SCHEDULING_RANGE).zip(@slots).to_h.reject { |_date, slot| slot.empty? if slot }
    @date_radio_options = @dates.keys

    @appointment = Appointment.new
  end

  # POST /appointments or /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    @rates = Constants::ACCEPTED_CURRENCIES.to_h { |c| [c, $fixer_client.convert(Constants::PRICE, c)] }

    respond_to do |format|
      if @appointment.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('appointment-form', partial: 'clients/form', locals: { app_id: @appointment.id, client: Client.new, rates: @rates })
        end
        format.html { redirect_to new_client_path, notice: "Appointment was successfully created." }
      else
        format.html { redirect_to new_appointment_path, notice: @appointment.errors }
      end
    end
  end

  def destroy
    @client = @appointment.client
    @appointment.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('appointments-list', partial: 'appointments/my_appointments', locals: { email: @client.email, appointments: @client.appointments })
      end
      format.html { redirect_to appointments_url, locals: { email: @client.email, appointments: @client.appointments }}
    end
  end

  def list
    @email = params[:email]
    @client = Client.find_by(email: @email)

    respond_to do |format|
      if @client
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('appointment-list-form', partial: 'appointments/my_appointments', locals: { appointments: @client.appointments })
        end
        format.html { redirect_to new_client_path, notice: "Appointment was successfully created." }
      else
        format.html { render '/appointments/index', status: :unprocessable_entity }
      end
    end
  end

  def download
    send_file InvoiceDownloader.generate_file(params[:format], params[:id]), filename: "invoice.#{params[:format]}", disposition: 'attachment'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:date, :time, :paid_amount, :doctor_id, :client_id)
    end
end
