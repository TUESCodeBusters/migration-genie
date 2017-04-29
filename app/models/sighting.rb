class Sighting < ApplicationRecord
    alias_attribute :user, :reporter

    has_one :reporter
    has_one :location
    has_one :species
end
