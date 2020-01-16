class CreateSemaines < ActiveRecord::Migration[5.1]
  def change
    create_table :semaines do |t|
      t.integer :numero_semaine
      t.date :date_lundi
      t.text :note

      t.timestamps
    end
  end
end
