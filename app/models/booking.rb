class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :stay

  validates :date_from,                          presence: true, allow_blank: false
  validates :date_to,                            presence: true, allow_blank: false
  validates :stay_length_in_months,              presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # validates_presence_of  :paid

  validates :date_from, :date_to, :overlap => {:scope => "stay_id"}
end
