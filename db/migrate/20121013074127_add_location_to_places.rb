class AddLocationToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :latitude,  :float
    add_column :places, :longitude, :float
    add_column :places, :gmaps,     :boolean
    add_column :places, :street,    :string
    add_column :places, :city,      :string
    add_column :places, :state,     :string
    add_column :places, :country,   :string
  end
end
