class AddExchangeRateColumnToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :exchange_rate, :float
  end
end
