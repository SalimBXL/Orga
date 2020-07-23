class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.date :date
      t.string :adresse
      t.integer :utilisateur_id
      t.string :description

      t.timestamps
    end
  end
end
