class AddReviewerToBlogMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_messages, :reviewer, :integer
  end
end
