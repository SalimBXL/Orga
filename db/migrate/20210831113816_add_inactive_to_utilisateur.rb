class AddInactiveToUtilisateur < ActiveRecord::Migration[5.1]
  def change
    add_column :utilisateurs, :inactive, :bool
  end
end
