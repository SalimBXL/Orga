class ChangeDateFormatInLogs < ActiveRecord::Migration[5.1]
  def change
    change_column :logs, :date, :datetime
  end
end
