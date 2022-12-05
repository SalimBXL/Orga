class CreateLienUtilisateurService < ActiveRecord::Migration[5.1]
  def change
    create_table :lien_utilisateur_service do |t|
      t.belongs_to :utilisateur, foreign_key: true
      t.belongs_to :service, foreign_key: true

      t.timestamps
    end
  end
end