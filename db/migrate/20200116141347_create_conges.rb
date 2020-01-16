class CreateConges < ActiveRecord::Migration[5.1]
  def change
    create_table :conges do |t|
      t.date :date
      t.boolean :accord
      t.string :remarque

      t.timestamps
    end
  end
end
