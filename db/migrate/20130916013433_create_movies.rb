class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.timestamp :date
      t.string :director
      t.string :genre
      t.integer :duration
      t.text :description

      t.timestamps
    end
  end
end
