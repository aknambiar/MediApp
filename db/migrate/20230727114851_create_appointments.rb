class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.string :date
      t.string :time
      t.integer :paid_amount
      t.belongs_to :doctor, null: false, foreign_key: true
      t.belongs_to :client, foreign_key: true, optional: true

      t.timestamps
    end
  end
end
