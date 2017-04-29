class Sighting < ApplicationRecord
    alias_attribute :user, :reporter

    belongs_to :reporter
    has_one :location
    has_one :species
end
