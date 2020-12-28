class ChangeConfigurationsToKonfigurations < ActiveRecord::Migration[5.1]
  def change
    rename_table :configurations, :konfigurations
  end
end
