class ChangeBatchNumberInBlogMessages < ActiveRecord::Migration[5.1]
  def change
    change_column :blog_messages, :batch_number, :string
  end
end
