class ChangeDefaultValueForWorkingHours < ActiveRecord::Migration[7.0]
  def change
    change_column_default :doctors, :working_hours, "12,14,15"
  end
end
