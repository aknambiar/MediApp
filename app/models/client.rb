class Client < ApplicationRecord
    has_many :appointments, dependent: :destroy
end
