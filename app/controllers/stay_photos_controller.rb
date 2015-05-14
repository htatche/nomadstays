class StayPhotosController < ApplicationController
  def destroy
    @photo = StayPhoto.find(params[:id])
    @photo.destroy

    redirect_to edit_stay_path(@photo.stay.id) 
  end

  def set_as_cover
    @photo = StayPhoto.find(params[:id])

    @photo.stay.stay_photos.each { |photo| 
      photo.cover = false
      photo.save
    }

    @photo.cover = true

    @photo.save

    redirect_to edit_stay_path(@photo.stay.id) 
  end
end
