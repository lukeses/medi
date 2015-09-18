class AddUserToPatient < ActiveRecord::Migration
  def change
    add_reference :patients, :user, index: true, foreign_key: true
  end
end
