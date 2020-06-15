class CreateDemandeConges < ActiveRecord::Migration[5.1]
  def change
    create_table :demande_conges do |t|
      t.date :date
      t.date :date_fin
      t.date :date_demande
      t.belongs_to :utilisateur, foreign_key: true

      t.timestamps
    end
  end
end
