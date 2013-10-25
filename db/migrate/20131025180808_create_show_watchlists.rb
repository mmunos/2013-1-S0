class CreateShowWatchlists < ActiveRecord::Migration
  def change
    create_table :show_watchlists do |t|
      t.references :show
      t.references :watchlist

      t.timestamps
    end
  end
end
