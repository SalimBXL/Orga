class CreateMaintenanceRessources < ActiveRecord::Migration[7.0]
  def change
    create_table :maintenance_ressources do |t|
      t.string :name
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
