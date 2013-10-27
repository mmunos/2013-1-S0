class CreateEpisodeTaggings < ActiveRecord::Migration
  def change
    create_table :episode_taggings do |t|
      t.references :episode, index: true
      t.references :tag

      t.timestamps
    end
  end
end
