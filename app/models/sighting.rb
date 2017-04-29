class Sighting < ApplicationRecord
    belongs_to :user
    has_one :location
    has_one :species

    mount_uploader :photo, SightingPhotoUploader
end
