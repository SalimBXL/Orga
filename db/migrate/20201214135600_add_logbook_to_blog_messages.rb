class AddLogbookToBlogMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_messages, :logbook, :boolean
  end
end
