class AddHiddenFieldToBlogResponses < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_responses, :hidden, :boolean
  end
end
