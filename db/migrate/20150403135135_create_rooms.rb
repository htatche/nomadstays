class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
    	t.belongs_to :house, index:true
    	t.belongs_to :apartment, index:true

      t.string :title
      t.string :sqm
      t.string :desk
      t.string :kitchen_access

      t.timestamps null: false
    end
  end
end
