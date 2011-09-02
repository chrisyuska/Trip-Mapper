class Trip < ActiveRecord::Base
  has_many :steps, :dependent => :destroy
  accepts_nested_attributes_for :steps, :reject_if => lambda { |a| a[:location].blank? }, :allow_destroy => true

  validates_presence_of :name, :email
  validates :marketable_url, :uniqueness => true

  attr_accessible :steps_attributes, :name, :email, :description, :marketable_url, :authentication_token
  
  before_validation :make_marketable_url

  before_create :generate_token

  def shareable_url
    "http://mapped.herokuapp.com/#{self.marketable_url}"
  end

  private

  def make_marketable_url
    self.marketable_url = self.name.downcase.gsub(/\W+/, "-")
  end

  def generate_token
    self.authentication_token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
