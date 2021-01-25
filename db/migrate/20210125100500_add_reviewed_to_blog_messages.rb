class AddReviewedToBlogMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_messages, :reviewed, :boolean
  end
end
