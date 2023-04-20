class AddBatchNumberToBlogMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_messages, :batch_number, :boolean
  end
end
