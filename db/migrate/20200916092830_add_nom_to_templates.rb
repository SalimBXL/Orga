class AddNomToTemplates < ActiveRecord::Migration[5.1]
  def change
    add_column :templates, :nom, :string
  end
end
