class CreateMovieUser < ActiveRecord::Migration
    def change
    create_table :movie_user do |t|


      t.timestamps
    end
  end
end
