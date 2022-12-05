class ChangeServiceToIntegerFromPostits < ActiveRecord::Migration[7.0]
  def change
    remove_column :postits, :service, :date
    add_column :postits, :service, :integer, references: :service
  end
end
