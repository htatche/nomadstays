class Stay < ActiveRecord::Base
  belongs_to :user

  has_one  :apartment,    :dependent => :destroy
  has_one  :house,        :dependent => :destroy
  has_many :rooms, through: :apartment
  has_many :rooms, through: :house

  accepts_nested_attributes_for :apartment
  accepts_nested_attributes_for :house

  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  validates_presence_of       :title
  validates_presence_of       :description

  validates_presence_of       :country
  validates_presence_of       :city
  validates_presence_of       :full_street_address

  validates_presence_of       :latitude
  validates_presence_of       :longitude

  validates_presence_of       :accomodation_type

  validates :accomodation_type, presence: true, allow_blank: false

  validates_inclusion_of :wifi, in: [true, false]

  def attached_rooms
    container = apartment || house
    container.rooms
  end

end