class CreateStays < ActiveRecord::Migration
  def change
    create_table :stays do |t|
      t.belongs_to :user, :index => true
      
      t.string  :title,                       :null => false
      t.float  :latitude
      t.float  :longitude
      t.string :city,                         :null => false
      t.string :state,                        :null => false
      t.string :country,                      :null => false
      t.string :street_address,               :null => false
      t.string :full_address,                 :null => false
      t.boolean :airport_pickup
      t.boolean :laundry
      t.boolean :cleaning
      t.boolean :data_sim_card
      t.boolean :wifi,                        :null => false
      t.string :wifi_speed
      t.boolean :mobile_data
      t.string :mobile_data_speed      
      t.string :accomodation_type
      t.boolean :terrace
      t.boolean :router_access
      t.boolean :desk
      t.text   :description
      t.boolean :not_available
      t.text    :not_available_reason
      t.timestamps null: false
    end
  end
end
