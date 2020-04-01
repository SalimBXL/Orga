class AddColumnToAbsences < ActiveRecord::Migration[5.1]
  def change
    add_column :absences, :date_fin, :date
  end
end
