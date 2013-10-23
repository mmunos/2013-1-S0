class CreateEpisodes < ActiveRecord::Migration
  def change
    drop_table :episodes

    create_table :episodes do |t|
      t.string :name
      t.text :description
      t.date :date
      t.integer :number
      t.string :write
      t.string :director
      t.integer :duration
      t.references :season, index: true

      t.timestamps
    end
  end
end
