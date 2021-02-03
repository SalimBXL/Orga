class AddHalfdayToAbsences < ActiveRecord::Migration[5.1]
  def change
    add_column :absences, :halfday, :boolean
  end
end
