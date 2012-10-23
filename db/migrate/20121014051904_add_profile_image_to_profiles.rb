class AddProfileImageToProfiles < ActiveRecord::Migration
  def change
  	add_column :profiles, :profile_image, :string
  end
end
