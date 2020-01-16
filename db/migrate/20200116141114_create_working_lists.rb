class CreateWorkingLists < ActiveRecord::Migration[5.1]
  def change
    create_table :working_lists do |t|
      t.belongs_to :work, foreign_key: true
      t.belongs_to :job, foreign_key: true

      t.timestamps
    end
  end
end
