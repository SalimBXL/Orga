class AddServiceToWorks < ActiveRecord::Migration[5.1]
  def change
    add_reference :works, :service, foreign_key: true
  end
end
