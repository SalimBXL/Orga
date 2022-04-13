class AddDateToProductions < ActiveRecord::Migration[5.1]
  def change
    add_column :productions, :mesure_date, :date
    add_column :productions, :mesure_time, :time
  end
end
