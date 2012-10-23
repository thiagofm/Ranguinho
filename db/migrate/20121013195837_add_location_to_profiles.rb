class AddLocationToProfiles < ActiveRecord::Migration
  def change
  	add_column :profiles, :latitude,  :float
    add_column :profiles, :longitude, :float
    add_column :profiles, :gmaps,     :boolean
    add_column :profiles, :street,    :string
    add_column :profiles, :city,      :string
    add_column :profiles, :state,     :string
    add_column :profiles, :country,   :string
  end
end
