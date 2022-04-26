class AddContactColumnToMaintenance < ActiveRecord::Migration[7.0]
  def change
    add_reference :maintenances, :contact, foreign_key: { to_table: :utilisateurs}
  end
end
