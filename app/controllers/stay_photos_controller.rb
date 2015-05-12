class StayPhotosController < ApplicationController
  def show
    @stay_photos = @stay.stay_photos.all
  end

  def new
    @stay = Stay.new
    @stay_attachment = @stay.stay_photos.build    
  end

  def create
   @stay = Stay.new(stay_params)

   respond_to do |format|
     if @stay.save
       params[:stay_photos]['file'].each do |a|
          @stay_attachment = @stay.stay_photos.create!(:file => a, :stay_id => @stay.id)
       end
       format.html { redirect_to @stay, notice: 'Stay was successfully created.' }
     else
       format.html { render action: 'new' }
     end
   end    
  end

 private

   def stay_params
      params.require(:stay).permit(:title, stay_photos_attributes: [:id, :stay_id, :file])
   end

end
