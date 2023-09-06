class ClientsController < ApplicationController
  include Constants

  # GET /clients/new
  def new
    render partial: "form", locals: { app_id: params[:app_id], client: Client.new, rates: params[:rates] }
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
        @client_helper.schedule_email(params[:app_id])
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('client-form', partial: 'appointments/success', locals: @client_helper.get_date_and_time)
        end
        format.html { redirect_to Appointment.find(params[:app_id]) }
      else
        @rates = Constants::ACCEPTED_CURRENCIES.to_h { |c| [c, $fixer_client.convert(Constants::PRICE, c)] }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('client-form', partial: 'clients/form', locals: { app_id: params[:app_id], client: Client.new, rates: @rates }), status: :unprocessable_entity
        end
        format.html { render :new, locals: { app_id: params[:app_id], client: Client.new, rates: @rates }, status: :unprocessable_entity }
      end
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def client_params
    params.require(:client).permit(:email, :currency_preference)
  end
end
