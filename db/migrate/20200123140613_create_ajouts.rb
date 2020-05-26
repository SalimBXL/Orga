class CreateAjouts < ActiveRecord::Migration[5.1]
  def change
    create_table :ajouts do |t|
      t.belongs_to :utilisateur, foreign_key: true
      t.date :date
      t.boolean :am_pm
      t.integer :work1
      t.integer :work2
      t.integer :work3
      t.integer :work4
      t.integer :work5

      t.timestamps
    end
  end
end
