class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name
      t.timestamp :date
      t.string :genre
      t.text :description
      t.string :director
      t.integer :duration
      t.string :type
      t.timestamps
    end
  end
end
