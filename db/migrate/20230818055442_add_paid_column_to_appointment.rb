class AddPaidColumnToAppointment < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :paid, :boolean, default: false
  end
end
