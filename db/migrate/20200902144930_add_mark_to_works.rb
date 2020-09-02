class AddMarkToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :mark, :boolean
  end
end
