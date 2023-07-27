class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.text :location
      t.string :working_hours, default: '12-13,14-16', null: false

      t.timestamps
    end
  end
end
