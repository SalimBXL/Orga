class AddUtilisateurToPostits < ActiveRecord::Migration[5.1]
  def change
    add_reference :postits, :utilisateur
  end
end
