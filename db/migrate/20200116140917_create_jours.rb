class CreateJours < ActiveRecord::Migration[5.1]
  def change
    create_table :jours do |t|
      t.belongs_to :utilisateur, foreign_key: true
      t.belongs_to :service, foreign_key: true
      
      t.string :numero_semaine
      t.date :date
      t.integer :numero_jour
      t.boolean :am_pm
      t.string :note

      t.timestamps
    end
  end
end
