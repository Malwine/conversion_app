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

  def get_rate(currency)
    
  end
end

class Amount

  attr_reader :amount, :original_currency

  def initialize(amount,original_currency)
    @amount = amount
    @original_currency = original_currency
  end

  def make_it_euros
  end

  def convert(target_currency)
  end
end


get '/' do
  erb :main, :locals => {:currencies => ConversionRate.currencies}
end

post '/converter' do
  #Amount.convert(ConversionRate)   not ready yet
  #erb :main, :locals => {}
  
end
