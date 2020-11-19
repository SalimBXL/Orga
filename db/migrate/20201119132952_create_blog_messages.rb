class CreateBlogMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :blog_messages do |t|
      t.belongs_to :utilisateur, foreign_key: true
      t.belongs_to :blog_category, foreign_key: true
      t.belongs_to :service, foreign_key: true
      
      t.string :title
      t.string :keywords
      t.text :description

      t.timestamps
    end
  end
end
