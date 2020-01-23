class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.belongs_to :groupe, foreign_key: true
      
      t.string :nom
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
