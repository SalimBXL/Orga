class AddRepeatToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :repeat, :integer
  end
end
