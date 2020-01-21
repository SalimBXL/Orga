class CreateConges < ActiveRecord::Migration[5.1]
  def change
    create_table :conges do |t|
      t.belongs_to :utilisateur, foreign_key: true
      
      t.date :date
      t.boolean :accord
      t.string :remarque

      t.timestamps
    end
  end
end
