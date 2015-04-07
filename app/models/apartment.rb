class Apartment < ActiveRecord::Base
	belongs_to :stay
	has_many :rooms,            through: :stay, :dependent => :delete_all 

  validates_presence_of       :nrooms
  validates_presence_of       :floor

  validates_inclusion_of :lift, in: [true, false]
  validates_inclusion_of :security, in: [true, false]

end
