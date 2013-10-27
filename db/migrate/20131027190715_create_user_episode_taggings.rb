class CreateUserEpisodeTaggings < ActiveRecord::Migration
  def change
    create_table :user_episode_taggings do |t|
      t.references :user, index: true
      t.references :episode, index: true
      t.references :tag

      t.timestamps
    end
  end
end
