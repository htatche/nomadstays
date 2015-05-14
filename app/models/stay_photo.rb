class StayPhoto < ActiveRecord::Base
  mount_uploader :file, PhotoUploader

  belongs_to :stay
end
