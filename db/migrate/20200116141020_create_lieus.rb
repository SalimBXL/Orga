class CreateLieus < ActiveRecord::Migration[5.1]
  def change
    create_table :lieus do |t|
      t.string :nom
      t.text :adresse
      t.string :phone
      t.string :Note

      t.timestamps
    end
  end
end
