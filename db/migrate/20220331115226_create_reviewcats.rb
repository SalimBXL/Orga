class CreateReviewcats < ActiveRecord::Migration[7.0]
  def change
    create_table :reviewcats do |t|
      t.string :cat
      t.timestamps
    end
  end
end
