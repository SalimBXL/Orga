class CreateWorkingLists < ActiveRecord::Migration[5.1]
  def change
    create_table :working_lists do |t|

      t.timestamps
    end
  end
end
