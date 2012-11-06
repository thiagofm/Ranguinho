class CountryValidator < ActiveModel::Validator
  def validate(record)
    if Country.find_country_by_alpha2(record.country).nil?
      record.errors[:base] << "Wrong country."
    end
  end
end

class StateValidator < ActiveModel::Validator
  def validate(record)
    # not really sure it does work
    if record.country?
      states = Country.find_country_by_alpha2(record.country)
                      .states
                      .map {|state| state[1]["name"] }
      unless states.include? record.state
        record.errors[:base] << "Wrong state."
      end
    end
  end
end

class Profile < ActiveRecord::Base
  attr_accessible :name, :street, :city, :state, :country, :gmaps, :profile_image, :profile_image_cache

  # Carrierwave uploader
  mount_uploader :profile_image, ProfileImageUploader

  # Geocoder
  reverse_geocoded_by :latitude, :longitude

  #Relations
  belongs_to :user

   # Validations
  validates :name,
            :presence => true

  validates :country,
            :presence => true

  validates :state,
            :presence => true

  validates :city,
            :presence => true

  validates :user_id,
            :presence => true,
            :uniqueness => true

  validates_with CountryValidator

  validates_with StateValidator

# Gmaps4rails
  acts_as_gmappable

  def gmaps4rails_address
    "#{self.street}, #{self.city}, #{self.state}, #{self.country}" 
  end

end
