class Opinion < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :place
  belongs_to :user

  attr_accessible :rate, :comment

  validates :place_id,
            :presence => true

  validates :user_id,
            :presence => true

  validates :rate,
            :presence => true
end
