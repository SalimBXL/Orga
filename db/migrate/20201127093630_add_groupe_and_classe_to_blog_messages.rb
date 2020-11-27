class AddGroupeAndClasseToBlogMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_messages, :groupe, :integer
    add_column :blog_messages, :classe, :integer
  end
end
