class AddServiceToHebdos < ActiveRecord::Migration[5.1]
  def change
    add_reference :hebdos, :service
  end
end
