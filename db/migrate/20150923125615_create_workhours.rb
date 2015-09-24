class CreateWorkhours < ActiveRecord::Migration
  def change
    create_table :workhours do |t|
      t.integer :weekday
      t.time :start
      t.time :finish
      t.references :work, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
