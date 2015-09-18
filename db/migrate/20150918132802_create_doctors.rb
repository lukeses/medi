class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.integer :pwz

      t.timestamps null: false
    end
  end
end
