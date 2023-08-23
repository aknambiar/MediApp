class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit update destroy ]

  # GET /appointments or /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1 or /appointments/1.json
  def show
    @appointment = Appointment.find(params[:id])
  end

  # GET /appointments/new
  def new
    @doctor = Doctor.find(params[:doctor_id])
    @slots = @doctor.weekly_available_slots
    # @slots = (1..10).to_a.map { ("1".."12").to_a }
    @dates = (DateRadioButton.today..DateRadioButton.today + Constants::SCHEDULING_RANGE).zip(@slots).to_h.reject { |_date, slot| slot.empty? }
    @date_radio_options = @dates.keys

    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
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
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1 or /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to appointment_url(@appointment), notice: "Appointment was successfully updated." }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to appointments_url, notice: "Appointment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def my_appointments
    @email = params[:email]
    Client.where(email: 'am@mail.com')

    respond_to do |format|
      if @appointment.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('appointment-form', partial: 'clients/form', locals: { app_id: @appointment.id, client: client_helper.client, rates: client_helper.rates })
        end
        format.html { redirect_to new_client_path, notice: "Appointment was successfully created." }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
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
