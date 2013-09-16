class CreateSerials < ActiveRecord::Migration
  def change
    create_table :serials do |t|
      t.string :name
      t.timestamp :date
      t.string :genre
      t.text :description

      t.timestamps
    end
  end
end
