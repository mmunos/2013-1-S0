class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.string :token
      t.references :user, index: true

      t.timestamps
    end
  end
end
