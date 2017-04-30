class Sighting < ApplicationRecord
    belongs_to :user
    has_one :location
    has_and_belongs_to_many :species
    accepts_nested_attributes_for :species
    accepts_nested_attributes_for :user
    mount_uploader :photo, SightingPhotoUploader
end
