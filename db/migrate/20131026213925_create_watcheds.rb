class CreateWatcheds < ActiveRecord::Migration
  def change
    create_table :watcheds do |t|
      t.references :user, index: true

      t.timestamps
    end

  	User.all.each do |user|
		unless user.watched
  			Watched.create(user: user)
  		end
  end
end
end
