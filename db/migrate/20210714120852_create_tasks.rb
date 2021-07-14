class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.belongs_to :groupe, foreign_key: true
      t.belongs_to :classe, foreign_key: true
      t.belongs_to :service, foreign_key: true
      
      t.string :nom
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
