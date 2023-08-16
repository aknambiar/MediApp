class AddCurrencyPreferenceColumnToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :currency_preference, :string, default: "INR"
  end
end
