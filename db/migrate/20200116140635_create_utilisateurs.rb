class CreateUtilisateurs < ActiveRecord::Migration[5.1]
  def change
    create_table :utilisateurs do |t|
      t.belongs_to :groupe
      t.belongs_to :service
      
      t.string :prenom
      t.string :nom
      t.date :date_de_naissance
      t.string :email
      t.string :phone
      t.string :gsm

      t.timestamps
    end
  end
end
