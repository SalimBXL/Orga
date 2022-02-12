class CreateTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :templates do |t|
      t.boolean :am_pm1
      t.integer :work1_1
      t.integer :work1_2
      t.integer :work1_3
      t.integer :work1_4
      t.integer :work1_5

      t.boolean :am_pm2
      t.integer :work2_1
      t.integer :work2_2
      t.integer :work2_3
      t.integer :work2_4
      t.integer :work2_5

      t.boolean :am_pm3
      t.integer :work3_1
      t.integer :work3_2
      t.integer :work3_3
      t.integer :work3_4
      t.integer :work3_5

      t.boolean :am_pm4
      t.integer :work4_1
      t.integer :work4_2
      t.integer :work4_3
      t.integer :work4_4
      t.integer :work4_5

      t.boolean :am_pm5
      t.integer :work5_1
      t.integer :work5_2
      t.integer :work5_3
      t.integer :work5_4
      t.integer :work5_5

      t.timestamps
    end
  end
end
