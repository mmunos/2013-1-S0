class CreateShowUsers < ActiveRecord::Migration
  def change
    create_table :show_users do |t|
      t.references :show
      t.references :user
      t.text :type
      
    end
  end
end
