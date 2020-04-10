class AddServiceToJobs < ActiveRecord::Migration[5.1]
  def change
    add_reference :jobs, :service, foreign_key: true
  end
end
