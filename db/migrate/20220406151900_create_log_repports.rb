class CreateLogRepports < ActiveRecord::Migration[5.1]
  def change
    create_table :log_repports do |t|
      t.string :controller
      t.text :action
      t.integer :count

      t.timestamps
    end
  end
end
