class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.references :doctor, index: true, foreign_key: true
      t.references :clinic, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
