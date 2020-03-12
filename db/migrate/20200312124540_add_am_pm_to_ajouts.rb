class AddAmPmToAjouts < ActiveRecord::Migration[5.1]
  def change
    add_column :ajouts, :am_pm, :boolean
  end
end
