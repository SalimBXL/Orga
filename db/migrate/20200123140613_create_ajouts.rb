class CreateAjouts < ActiveRecord::Migration[5.1]
  def change
    create_table :ajouts do |t|
      t.integer :utilisateur
      t.integer :numero_jour
      t.date :date_lundi
      t.integer :work1
      t.integer :work2
      t.integer :work3
      t.integer :work4
      t.integer :work5

      t.timestamps
    end
  end
end
