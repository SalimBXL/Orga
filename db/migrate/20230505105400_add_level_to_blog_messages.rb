class AddLevelToBlogMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_messages, :level, :integer, :default => 0
  end
end
