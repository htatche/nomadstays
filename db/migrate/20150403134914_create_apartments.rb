class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
    	t.belongs_to :stay, index:true

      t.integer :nrooms
      t.integer :floor
      t.boolean :lift
      t.boolean :security

      t.timestamps null: false
    end
  end
end
