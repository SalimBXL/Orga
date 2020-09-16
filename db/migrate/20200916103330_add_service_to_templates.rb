class AddServiceToTemplates < ActiveRecord::Migration[5.1]
  def change
    add_column :templates, :service_id, :integer
  end
end
