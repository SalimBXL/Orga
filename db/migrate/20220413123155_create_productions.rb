class CreateProductions < ActiveRecord::Migration[7.0]
  def change
    create_table :productions do |t|
      t.references :traceur, null: false, foreign_key: true
      t.float :quantity
      t.references :prod_unit, null: false, foreign_key: true
      t.references :prod_destination, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.references :utilisateur, null: false, foreign_key: true

      t.timestamps
    end
  end
end
