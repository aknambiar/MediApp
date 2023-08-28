class Client < ApplicationRecord
    has_many :appointments, dependent: :destroy

    validates :email, presence: true, uniqueness: true
end
