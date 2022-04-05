class AddReviewcatToBlogMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_messages, :reviewcat, :integer
  end
end
