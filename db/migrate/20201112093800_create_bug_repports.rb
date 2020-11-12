class CreateBugRepports < ActiveRecord::Migration[5.1]
  def change
    create_table :bug_repports do |t|
      t.belongs_to :utilisateur, foreign_key: true

      t.date :date
      t.string :nom
      t.text :description

      t.timestamps
    end
  end
end
