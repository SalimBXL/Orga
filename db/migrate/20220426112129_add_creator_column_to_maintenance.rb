class AddCreatorColumnToMaintenance < ActiveRecord::Migration[7.0]
  def change
    add_reference :maintenances, :creator, foreign_key: { to_table: :utilisateurs}
  end
end
