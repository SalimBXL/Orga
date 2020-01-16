class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.integer :numero_jour
      t.boolean :am_pm
      t.string :note

      t.timestamps
    end
  end
end
