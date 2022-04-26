class CreateMaintenances < ActiveRecord::Migration[7.0]
  def change
    create_table :maintenances do |t|
      t.string :name
      t.date :date_start
      t.date :date_end


      t.timestamps
    end
  end
end
