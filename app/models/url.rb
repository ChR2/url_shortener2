require 'faker'

class Url < ActiveRecord::Base
  validates :long_url, presence: true
  validates :short_url, uniqueness: true
  before_save :short_url_generator
  
  
  def self.url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end 


  def short_url_generator
    self.short_url = Faker::Lorem.characters(6)
  end

end
