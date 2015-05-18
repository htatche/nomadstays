class CreateStays < ActiveRecord::Migration
  def change
    create_table :stays do |t|
      t.belongs_to :user, :index => true
      
      t.string    :title,                       :null => false
      t.text      :description

      t.string    :accomodation_type

      t.float     :latitude
      t.float     :longitude

      t.string    :street_address,               :null => false
      t.string    :city,                         :null => false
      t.string    :state,                        :null => false
      t.string    :country_name,                 :null => false
      t.string    :country_code,                 :null => false
      t.string    :full_address,                 :null => false

      t.boolean   :wifi,                         :null => false
      t.string    :wifi_speed
      t.boolean   :mobile_data
      t.string    :mobile_data_speed      

      t.boolean   :terrace
      t.boolean   :router_access
      t.boolean   :desk

      t.boolean   :service_pickup
      t.integer   :service_pickup_price

      t.boolean   :service_laundry
      t.integer   :service_laundry_price

      t.boolean   :service_cleaning
      t.integer   :service_cleaning_price

      t.boolean   :service_sim_card
      t.integer   :service_sim_card_price

      t.boolean   :available

      t.integer   :monthly_price

      t.timestamps null: false
    end
  end
end
