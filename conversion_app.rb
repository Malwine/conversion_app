require 'sinatra'
require 'nokogiri'
require 'open-uri'

class ConversionRate
  
  def self.fetch_list
    open('https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml')
  end

  def self.currencies   #class method
    new(fetch_list).currencies
  end 
   
  attr_reader :ecb_rates_file

  def initialize(ecb_rates_file)
    @ecb_rates_file = ecb_rates_file
  end

  def currencies
    doc = Nokogiri::XML(ecb_rates_file)
    doc.css('Cube[currency]').map do |currency|
      currency["currency"]
    end 
  end
end

get '/' do
  erb :main, :locals => {:currencies => ConversionRate.currencies}
end

post '/converter' do
  #Conversion.convert(ConversionRate)   not ready yet

  
end
