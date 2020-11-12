class AddStatusToBugRepports < ActiveRecord::Migration[5.1]
  def change
    add_column :bug_repports, :status, :string
  end
end
