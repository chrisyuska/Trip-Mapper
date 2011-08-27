class Trip < ActiveRecord::Base
  has_many :steps, :dependent => :destroy
  accepts_nested_attributes_for :steps, :reject_if => lambda { |a| a[:location].blank? }, :allow_destroy => true

  validates_presence_of :name, :email
  validates :marketable_url, :uniqueness => true

  attr_accessible :steps_attributes, :name, :email, :description, :marketable_url
  
  before_validation :make_marketable_url

  def shareable_url
    "http://mapper.lithoslabs.com/#{self.marketable_url}"
  end

  private

  def make_marketable_url
    self.marketable_url = self.name.downcase.gsub(/\W+/, "-")
  end
end
