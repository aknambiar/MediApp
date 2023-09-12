class AddCurrencyColumnToAppointment < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :currency, :string
  end
end
