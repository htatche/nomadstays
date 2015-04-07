class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
    	# t.belongs_to :house, index:true
    	# t.belongs_to :apartment, index:true
      t.belongs_to :stay, index:true

      t.string :title
      t.integer :sqm
      t.boolean :desk
      t.boolean :kitchen_access
      t.integer :monthly_price
      t.boolean :available

      t.timestamps null: false
    end
  end
end
