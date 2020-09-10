class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.belongs_to :service, foreign_key: true
      t.string :note
      t.date :date
      t.date :date_fin
      t.belongs_to :utilisateur, foreign_key: true
      t.timestamps
    end
  end
end
