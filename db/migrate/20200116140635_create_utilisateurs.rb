class CreateUtilisateurs < ActiveRecord::Migration[5.1]
  def change
    create_table :utilisateurs do |t|
      t.belongs_to :groupe, foreign_key: true
      t.belongs_to :service, foreign_key: true
      
      t.string :prenom
      t.string :nom
      t.string :email
      t.string :phone
      t.string :gsm
      

      t.timestamps
    end
  end
end
