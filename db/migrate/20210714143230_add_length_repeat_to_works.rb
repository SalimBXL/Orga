class AddLengthRepeatToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :length, :integer
    add_column :works, :repeat, :integer
  end
end
