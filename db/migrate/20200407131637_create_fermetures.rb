class CreateFermetures < ActiveRecord::Migration[5.1]
  def change
    create_table :fermetures do |t|
      t.string :nom
      t.date :date
      t.date :date_fin
      t.string :note
      t.belongs_to :service, foreign_key: true

      t.timestamps
    end
  end
end
