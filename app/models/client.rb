class Client < ApplicationRecord
  has_many :appointments, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validate :email_format

  def email_format
    errors.add(:email, "Invalid Email") unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end
end