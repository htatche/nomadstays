class CreateStayPhotos < ActiveRecord::Migration
  def change
    create_table :stay_photos do |t|
      t.integer :stay_id
      t.string :file

      t.timestamps null: false
    end
  end
end
