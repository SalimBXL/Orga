class AddLastConnectionToUtilisateurs < ActiveRecord::Migration[5.1]
  def change
    add_column :utilisateurs, :last_connection, :datetime
  end
end
