class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.integer :mobile_number
      t.text :address

      t.timestamps
    end
  end
end
