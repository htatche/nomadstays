module ApplicationHelper
  def accomodation_types
    [["All", ""], ["Apartment", "Apartment"], ["House", "House"], ["Room", "Room"]]
  end

  def internet_speed_types
    [["All", ""],  ["< 1 Mbps", "< 1 Mbps"], ["1 - 3 Mbps", "1 - 3 Mbps"], ["5 Mbps", "5 Mbps"], ["10 Mbps", "10 Mbps"], ["> 10 Mbps", "> 10 Mbps"]]
  end  
end
