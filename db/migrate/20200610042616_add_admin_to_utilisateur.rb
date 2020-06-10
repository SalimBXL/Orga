class AddAdminToUtilisateur < ActiveRecord::Migration[5.1]
  def change
    add_column :utilisateurs, :admin, :bool
  end
end
