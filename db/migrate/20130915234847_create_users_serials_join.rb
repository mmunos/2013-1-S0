class CreateUsersSerialsJoin < ActiveRecord::Migration
  def change
    create_table :serials_users do |t|
    	t.belongs_to :user
    	t.belongs_to :serial
    end
  end
end
