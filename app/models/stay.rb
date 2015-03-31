class Stay < ActiveRecord::Base
	geocoded_by :full_street_address   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates


	validates_presence_of   		:country
	validates_presence_of   		:city
	validates_presence_of   		:full_street_address

	validates_presence_of  			:latitude
  validates_presence_of				:longitude
end
