class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.start :datetime
      t.finish :datetime
      t.references :patient, index: true, foreign_key: true
      t.references :doctor, index: true, foreign_key: true
      t.references :clinic, index: true, foreign_key: true
      t.boolean :confirmed

      t.timestamps null: false
    end
  end
end
