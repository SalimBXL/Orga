class AddTakenToPostits < ActiveRecord::Migration[5.1]
  def change
    add_reference :postits, :taken, foreign_key: { to_table: :utilisateurs}
  end
end
