class AddColumnToConges < ActiveRecord::Migration[5.1]
  def change
    add_column :conges, :date_fin, :date
  end
end
