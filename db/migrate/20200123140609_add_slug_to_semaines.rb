class AddSlugToSemaines < ActiveRecord::Migration[5.1]
  def change
    add_column :semaines, :slug, :string
    add_index :semaines, :slug
  end
end
