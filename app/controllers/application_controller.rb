class ApplicationController < ActionController::Base
  before_action :set_locale, :load_user_session

  protected

  def set_locale
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def load_user_session
    @current_user = Client.find_by(email: cookies[:email])
  end
end
