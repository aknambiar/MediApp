class Client < ApplicationRecord
  has_many :appointments, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validate :email_format, :supported_currency

  private

  def email_format
    errors.add(:email, I18n.t('error_message_email')) unless Constants::EMAIL_REGEXP.match(email)
  end

  def supported_currency
    errors.add(:currency_preference, I18n.t('models.errors.unsupported_currency')) unless Constants::ACCEPTED_CURRENCIES.include?(currency_preference)
  end
end