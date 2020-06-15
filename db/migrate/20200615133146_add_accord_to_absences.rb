class AddAccordToAbsences < ActiveRecord::Migration[5.1]
  def change
    add_column :absences, :accord, :boolean
  end
end
