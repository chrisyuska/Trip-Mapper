class Step < ActiveRecord::Base
  belongs_to :trip

  validates_presence_of :arrival, :departure, :location
  geocoded_by :location, :latitude => :lat, :longitude => :lng
  after_validation :geocode
end
