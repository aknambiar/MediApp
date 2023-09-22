class ClientsController < ApplicationController
  before_action :authenticate_user, only: :show
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
    client_helper = ClientPartialHelper.new(client_params, params)

    respond_to do |format|
      if client_helper.process_appointment
        cookies.permanent[:email] = client_params[:email]
        format.turbo_stream { render turbo_stream: turbo_stream.replace('client-form', partial: 'appointments/success', locals: { appointment: client_helper.appointment }) }
        format.html { redirect_to Appointment.find(params[:appointment_id]) }
      else
        format.turbo_stream do
          flash.now[:notice] = true
          render turbo_stream: turbo_stream.replace('client-form', partial: 'clients/form', locals: { appointment_id: params[:appointment_id], rates: $fixer_client.standard_prices })
        end
        format.html { render :new, locals: { appointment_id: params[:appointment_id], rates: $fixer_client.standard_prices }, status: :unprocessable_entity }
      end
    end
  end

  def create_user_session
    client = Client.find_by(email: params[:email])
    render(action: :login, status: :unprocessable_entity) && return unless client

    cookies.permanent[:email] = params[:email]
    redirect_to client
  end

  private
  # Only allow a list of trusted parameters through.
  def client_params
    params.require(:client).permit(:email, :currency_preference)
  end

  def authenticate_user
    @client = Client.find(params[:id])
    redirect_to login_path unless @client.email == cookies[:email]
  end
end
