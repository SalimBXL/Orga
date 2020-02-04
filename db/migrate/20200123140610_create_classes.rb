class CreateClasses < ActiveRecord::Migration[5.1]
  def change
    create_table :classes do |t|
      t.string :nom
      t.string :description

      t.timestamps
    end
  end
end
