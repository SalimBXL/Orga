class ChangeLienUtilisateurService < ActiveRecord::Migration[5.1]
  def change
    rename_table :lien_utilisateur_service, :lien_utilisateur_services
  end
end
