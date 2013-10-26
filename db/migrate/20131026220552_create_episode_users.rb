class CreateEpisodeUsers < ActiveRecord::Migration
  def change
    create_table :episode_users do |t|
      t.references :episode
      t.references :watched

      t.timestamps
    end
  end
end
