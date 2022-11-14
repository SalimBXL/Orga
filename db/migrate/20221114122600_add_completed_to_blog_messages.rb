class AddCompletedToBlogMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_messages, :completed, :boolean
    add_column :blog_messages, :final_reviewer, :integer
  end
end
