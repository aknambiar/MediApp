class AddExchangeRateColumnToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :exchange_rate, :integer
  end
end
