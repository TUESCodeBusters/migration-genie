class Species < ApplicationRecord
    has_one :location
    has_and_belongs_to_many :sightings
    accepts_nested_attributes_for :sightings
end
