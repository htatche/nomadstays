class Stay < ActiveRecord::Base
	belongs_to :user

	has_one  :apartment
	has_one  :house
	has_many :rooms, through: :apartment
	has_many :rooms, through: :house

	accepts_nested_attributes_for :apartment
	accepts_nested_attributes_for :house

	geocoded_by :full_street_address   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates

	validates_presence_of   		:title
	validates_presence_of   		:description

	validates_presence_of   		:country
	validates_presence_of   		:city
	validates_presence_of   		:full_street_address

	validates_presence_of  			:latitude
  validates_presence_of				:longitude

  def container
  	stay.apartment || stay.house
  end

end