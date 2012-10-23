class User < ActiveRecord::Base
  # Friendly Id Gem - Generates slug for this model
  include FriendlyId
  friendly_id :username, use: [:slugged]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  # attr_accessible :title, :body
  
  # Validations
  validates :username, :presence => true,
                       :uniqueness => true,
                       :length => { :in => 2..30 },
                       :format => { :with => /^[a-zA-Z0-9._]*$/, :message => 'Only alphabetic characters, numbers and _ is allowed'}

  # Relations
  has_many :places
  has_many :opinions
  has_one :profile

  # this makes sure that user is able to sign in with email or username
  def self.find_for_database_authentication(conditions={})
    self.where("username = ?", conditions[:email]).limit(1).first ||
    self.where("email = ?", conditions[:email]).limit(1).first
  end
end
