class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.string :url_title
      t.string :url
      t.text :content
      t.string :post_type
      t.references :commentable , polymorphic: true

      t.timestamps
    end
  end
end
