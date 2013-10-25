class CreateWatchlists < ActiveRecord::Migration
  def change
    create_table :watchlists do |t|
      t.references :user, index: true

      t.timestamps
    end

  	User.all.each do |user|
		unless user.watchlist
  			Watchlist.create(user: user)
  		end
  	end
  end
end
