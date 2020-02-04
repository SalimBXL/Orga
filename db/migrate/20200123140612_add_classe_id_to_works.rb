class AddClasseIdToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :classe_id, :bigint
    add_index :works, :classe_id
  end
end
