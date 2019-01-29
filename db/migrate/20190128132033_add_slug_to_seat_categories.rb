class AddSlugToSeatCategories < ActiveRecord::Migration[5.2]
  def change
  	add_column :seat_categories, :slug, :string
    add_index :seat_categories, :slug, unique: true
  end
end
