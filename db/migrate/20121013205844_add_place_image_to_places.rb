class AddPlaceImageToPlaces < ActiveRecord::Migration
  def change
  	add_column :places, :place_image, :string
  end
end
