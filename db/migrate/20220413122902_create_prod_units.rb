class CreateProdUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :prod_units do |t|
      t.string :name

      t.timestamps
    end
  end
end
