class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :user,                             index: true
      t.belongs_to :stay,                             index: true

      t.date :date_from,                              null: false 
      t.date :date_to,                                null: false
      t.integer :stay_length_in_months,               null: false

      t.boolean :paid,                                null: false, unique: true, default: false
      t.string  :status                            

      t.boolean :service_pickup
      t.boolean :service_laundry
      t.boolean :service_cleaning
      t.boolean :service_sim_card

      t.text :special_request

      t.timestamps null: false
    end
  end
end
