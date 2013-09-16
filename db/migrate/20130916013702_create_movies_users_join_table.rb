class CreateMoviesUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :movies_users, id: false do |t|
      t.references :movie
      t.references :user
    end
    
    add_index :movies_users, [:movie_id, :user_id], unique: true
  end
end
