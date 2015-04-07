FactoryGirl.define do
  factory :booking do
    user_id "MyString"
stay_id "MyString"
paid false
accepted false
date_from "2015-04-06"
date_to ""
service_pickup false
service_laundry false
service_cleaning false
service_sim_card false
special_request "MyText"
  end

end
