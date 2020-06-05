class AddUserToUtilisateur < ActiveRecord::Migration[5.1]
  def change
    add_reference :utilisateurs, :user, foreign_key: true
  end
end
