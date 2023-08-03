class ChangeMobileNumberToString < ActiveRecord::Migration[7.0]
  def up
    change_column :clients, :mobile_number, :string
  end

  def down
    change_column :clients, :mobile_number, :integer
  end
end
