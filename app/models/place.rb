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

class Place < ActiveRecord::Base
  attr_accessible :description, :title, :street, :city, :state, :country, :place_image, :place_image_cache, :opinions_attributes

  # Relations
  belongs_to :user
  has_many :opinions

  # Validations
  validates :title, :presence => true,
                    :length => { :in => 4..30 }

  validates :country,
            :presence => true

  validates :state,
            :presence => true

  validates :city,
            :presence => true

  validates :user_id,
            :presence => true

  validates_with CountryValidator

  validates_with StateValidator

  # Gmaps4rails
  acts_as_gmappable

  # nested_form
  accepts_nested_attributes_for :opinions

  # Friendly Id Gem - Generates slug for this model
  include FriendlyId
  friendly_id :title, use: [:slugged]

  # Geocoder
  reverse_geocoded_by :latitude, :longitude

  # Carrierwave uploader
  mount_uploader :place_image, PlaceImageUploader

  def gmaps4rails_address
    "#{self.street}, #{self.city}, #{self.state}, #{self.country}" 
  end
end


