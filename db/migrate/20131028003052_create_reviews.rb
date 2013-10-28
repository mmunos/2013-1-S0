class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user, index: true
      t.float :rating
      t.text :content
      t.references :reviewable, polymorphic: true

      t.timestamps
    end
  end
end
