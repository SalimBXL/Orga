class CreateAbsences < ActiveRecord::Migration[5.1]
  def change
    create_table :absences do |t|
      t.belongs_to :type_absence, foreign_key: true
      
      t.date :date
      t.string :remarque

      t.timestamps
    end
  end
end
