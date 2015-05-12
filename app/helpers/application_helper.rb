module ApplicationHelper
  def accomodation_types
    [["Apartment", "Apartment"], ["House", "House"], ["Room", "Room"]]
  end

  def internet_speed_types
    [["All", ""],  ["< 1 Mbps", "< 1 Mbps"], ["1 - 3 Mbps", "1 - 3 Mbps"], ["5 Mbps", "5 Mbps"], ["10 Mbps", "10 Mbps"], ["> 10 Mbps", "> 10 Mbps"]]
  end  

  def months_to_stay
    [["1 Month", 1],  ["2 Months", 2], ["3 Months", 3]]
  end    
end