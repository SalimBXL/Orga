class AddServiceToPostits < ActiveRecord::Migration[5.1]
  def change
    add_column :postits, :service, :date
  end
end
