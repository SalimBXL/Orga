class CreateUtilisateurs < ActiveRecord::Migration[5.1]
  def change
    create_table :utilisateurs do |t|
      t.string :prenom
      t.string :nom
      t.string :email
      t.string :phone
      t.string :gsm

      t.timestamps
    end
  end
end
