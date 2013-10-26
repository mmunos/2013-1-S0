class CreateMovieUsers < ActiveRecord::Migration
  def change
    create_table :movie_users do |t|
      t.references :show
      t.references :watched

      t.timestamps
    end
  end
end
