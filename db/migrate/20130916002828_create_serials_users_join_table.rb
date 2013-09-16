class CreateSerialsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :serials_users, id: false do |t|
      t.references :serial
      t.references :user
    end
    
    add_index :serials_users, [:serial_id, :user_id], unique: true
  end
end
