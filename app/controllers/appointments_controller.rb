class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit update destroy ]
  before_action :cookie_login, only: :index

  # GET /appointments or /appointments.json
  def index
    @appointments = Appointment.all
    @email = cookies[:email] || nil
  end

  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @doctor = Doctor.find(params[:doctor_id])
    @dates = @doctor.available_slots_for_range
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
          render turbo_stream: turbo_stream.replace('appointment-form', partial: 'clients/form', locals: { appointment_id: @appointment.id, client: Client.new, rates: @rates })
        end
        format.html { redirect_to new_client_path(appointment_id: @appointment.id, client: Client.new, rates: @rates) }
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

  # Can move this to index action?
  def list
    @email = params[:email]
    @client = Client.find_by(email: @email)
    cookies.permanent[:email] = @email

    respond_to do |format|
      if @client
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('appointment-list-form', partial: 'appointments/my_appointments', locals: { appointments: @client.appointments })
        end
        format.html { redirect_to @client }
      else
        format.html { render action: "index", status: :unprocessable_entity }
      end
    end
  end

  def download
    send_file InvoiceDownloader.new.generate_file(params[:format], params[:id]), filename: "#{params[:id]}.#{params[:format]}", disposition: 'attachment' if Constants::DOWNLOAD_FORMATS.include?(params[:format])
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

    def cookie_login
      redirect_to get_list_appointment_path(email: cookies[:email]) if cookies[:email]
    end
end
