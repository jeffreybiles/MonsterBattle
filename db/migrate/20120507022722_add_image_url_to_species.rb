class AddImageUrlToSpecies < ActiveRecord::Migration
  def change
    add_column :species, :image_url, :string
  end
end
