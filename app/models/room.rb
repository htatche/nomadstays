class Room < ActiveRecord::Base
	belongs_to :house
	belongs_to :apartment

  validates_presence_of       :title
  
  validates :sqm, numericality: { only_integer: true, greater_than: 0 }

  validates_inclusion_of :desk, in: [true, false]
  validates_inclusion_of :kitchen_access, in: [true, false]
end
