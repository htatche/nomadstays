class AddPhotosToStays < ActiveRecord::Migration
  def change
    add_column :stays, :photos, :json
  end
end
