class AddUserToAdmin < ActiveRecord::Migration
  def change
    add_reference :admins, :user, index: true, foreign_key: true
  end
end
