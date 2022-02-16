class AddDoneAtToPostits < ActiveRecord::Migration[5.1]
  def change
    add_column :postits, :done_at, :date
  end
end
