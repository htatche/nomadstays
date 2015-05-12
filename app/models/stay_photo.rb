class StayPhoto < ActiveRecord::Base
  mount_uploader :file, PhotoUploader
end
