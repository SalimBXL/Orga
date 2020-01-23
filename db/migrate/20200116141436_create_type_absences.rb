class CreateTypeAbsences < ActiveRecord::Migration[5.1]
  def change
    create_table :type_absences do |t|
      t.string :code
      t.string :nom
      t.string :description

      t.timestamps
    end
  end
end
