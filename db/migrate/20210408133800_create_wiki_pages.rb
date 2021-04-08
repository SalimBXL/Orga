class CreateWikiPages < ActiveRecord::Migration[5.1]
  def change
    create_table :wiki_pages do |t|

      t.integer :utilisateur_id
      t.integer :blog_category_id
      t.integer :service_id
      t.integer :groupe_id
      t.string :keywords
      
      t.string :title
      t.text :problem_description
      t.text :solution_short
      t.text :solution_long

      t.integer :blog_message_id

      t.timestamps
    end
  end
end
