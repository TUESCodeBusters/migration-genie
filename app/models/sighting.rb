class Sighting < ApplicationRecord
    belongs_to :user
    has_one :location
    has_one :species
    accepts_nested_attributes_for :species
    accepts_nested_attributes_for :user
    mount_uploader :photo, SightingPhotoUploader

    def species_attributes=(attributes)
        self.species = Species.where(attributes).first_or_create
    end
end
