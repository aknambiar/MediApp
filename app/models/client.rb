class Client < ApplicationRecord
  has_many :appointments, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validate :email_format, :supported_currency

  private

  def email_format
    errors.add(:email, "Invalid Email") unless Constants::EMAIL_REGEXP.match(email)
  end

  def supported_currency
    errors.add(:currency_preference, "Currency not supported") unless Constants::ACCEPTED_CURRENCIES.include?(currency_preference)
  end
end