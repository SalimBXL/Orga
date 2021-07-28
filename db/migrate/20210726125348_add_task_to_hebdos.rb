class AddTaskToHebdos < ActiveRecord::Migration[5.1]
  def change
    add_reference :hebdos, :task, foreign_key: true
  end
end
