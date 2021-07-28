class CreateHebdos < ActiveRecord::Migration[5.1]
  def change
    create_table :hebdos do |t|
      t.belongs_to :utilisateur, foreign_key: true
      t.string :numero_semaine
      t.string :note

      t.timestamps
    end
  end
end
