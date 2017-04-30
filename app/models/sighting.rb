class Sighting < ApplicationRecord
    belongs_to :user
    has_one :location
    has_one :species
    accepts_nested_attributes_for :species
    accepts_nested_attributes_for :user
    accepts_nested_attributes_for :location
    mount_uploader :photo, SightingPhotoUploader

    def species_attributes=(attributes)
        self.species = Species.where(attributes).first_or_create
        self.species_id = self.species.id
    end

    def location_attributes=(attributes)
        self.location = Location.where(attributes).first_or_create
        self.location_id = self.location.id
    end
end
