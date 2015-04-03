class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
    	t.belongs_to :stay, index:true

      t.boolean :garden
      t.boolean :terrace
      t.boolean :alarm

      t.timestamps null: false
    end
  end
end
