class AddWorkIdToClasses < ActiveRecord::Migration[5.1]
  def change
    add_column :classes, :work_id, :integer
    add_index :classes, :work_id
  end
end
