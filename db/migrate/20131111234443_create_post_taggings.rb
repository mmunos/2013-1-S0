class CreatePostTaggings < ActiveRecord::Migration
  def change
    create_table :post_taggings do |t|
      t.references :post, index: true
      t.references :tag

      t.timestamps
    end
  end
end
