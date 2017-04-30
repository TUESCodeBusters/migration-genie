class SightingsChannel < ApplicationCable::Channel  
  def subscribed
    stream_from 'sightings'
  end
end 