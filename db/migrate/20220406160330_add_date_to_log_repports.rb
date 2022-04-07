class AddDateToLogRepports < ActiveRecord::Migration[5.1]
  def change
    add_column :log_repports, :date, :date
    add_column :log_repports, :hour, :integer
    add_column :log_repports, :minute, :integer
  end
end
