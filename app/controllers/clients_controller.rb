class ClientsController < ApplicationController
  before_action :user_exists?, only: :login
  include Constants

  # GET /clients/new
  def new
    render :new, locals: { appointment_id: params[:appointment_id], rates: params[:rates] }
  end

  # GET /clients/1
  def show
    @client = Client.find(params[:id])
  end

  # POST /clients or /clients.json
  def create
    @client_helper = ClientPartialHelper.new(client_params, params)
    @payment_processor = PaymentProcessor.new.pay

    respond_to do |format|
      if @client_helper.update && @payment_processor
        cookies.permanent[:email] = client_params[:email]
        @client_helper.schedule_email
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('client-form', partial: 'appointments/success', locals: @client_helper.get_date_and_time)
        end
        format.html { redirect_to Appointment.find(params[:appointment_id]) }
      else
        @rates = Constants::ACCEPTED_CURRENCIES.to_h { |c| [c, $fixer_client.convert(Constants::PRICE, c)] }
        format.turbo_stream do
          flash.now[:notice] = true
          render turbo_stream: turbo_stream.replace('client-form', partial: 'clients/form', locals: { appointment_id: params[:appointment_id], rates: @rates })
        end
        format.html { render :new, locals: { appointment_id: params[:appointment_id], rates: @rates }, status: :unprocessable_entity }
      end
    end
  end

  def login
    @email = cookies[:email] || nil
  end

  def create_user_session
    @email = params[:email]
    @client = Client.find_by(email: @email)

    respond_to do |format|
      if @client
        cookies.permanent[:email] = @email
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('client-login-form', partial: 'my_appointments', locals: { appointments: @client.appointments })
        end
        format.html { redirect_to @client }
      else
        format.html { render action: "login", status: :unprocessable_entity }
      end
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def client_params
    params.require(:client).permit(:email, :currency_preference)
  end

  def user_exists?
    redirect_to get_session_path(email: cookies[:email]) if cookies[:email]
  end
end
