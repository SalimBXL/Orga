class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :nom
      t.date :date
      t.string :note
      t.belongs_to :service, foreign_key: true

      t.timestamps
    end
  end
end
