class AddMaintenanceRessourceToMaintenances < ActiveRecord::Migration[5.1]
  def change
    add_reference :maintenances, :maintenance_ressource
  end
end
