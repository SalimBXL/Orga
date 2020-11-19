class AddDateToBlogMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_messages, :date, :datetime
  end
end
