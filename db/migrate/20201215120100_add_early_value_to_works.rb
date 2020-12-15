class AddEarlyValueToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :early_value, :integer
  end
end
