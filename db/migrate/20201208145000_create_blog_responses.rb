class CreateBlogResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :blog_responses do |t|
      t.belongs_to :utilisateur, foreign_key: true
      t.belongs_to :blog_message, foreign_key: true
      
      t.text :description

      t.timestamps
    end
  end
end
