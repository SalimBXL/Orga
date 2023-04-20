class AddRadioprotectionToBlogMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_messages, :radioprotection, :boolean
  end
end
