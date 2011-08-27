class Step < ActiveRecord::Base
  belongs_to :trip

  validates_presence_of :arrival, :departure, :location
  geocoded_by :location, :latitude => :lat, :longitude => :lng
  after_validation :geocode
  
  before_save :make_pretty

  private

  def make_pretty
    self.location = self.location.capitalize
  end
end
