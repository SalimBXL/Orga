class FixPostits < ActiveRecord::Migration[7.0]
  def change
    rename_column :postits, :service, :service_id
  end
end
