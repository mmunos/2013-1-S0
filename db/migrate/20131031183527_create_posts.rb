class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.text :content
      t.references :commentable , polymorphic: true

      t.timestamps
    end
  end
end