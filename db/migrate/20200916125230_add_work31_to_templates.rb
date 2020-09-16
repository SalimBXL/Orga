class AddWork31ToTemplates < ActiveRecord::Migration[5.1]
  def change
    add_column :templates, :work3_1, :integer
  end
end
