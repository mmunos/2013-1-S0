class AddPosterToMovies < ActiveRecord::Migration
  def change
    add_column :shows, :poster, :string
  end
end
