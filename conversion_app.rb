require 'sinatra'
require 'nokogiri'
require 'open-uri'

class ConversionRate

  @rates = {"EUR" => 1,
            "USD" => 1.3,
            "HUF" => 309,
            "DKK" => 7.4,
            "AUD" => 1.5,
            "JPY" => 139.4,
            "THB" => 44.2}
  
  def self.fetch_list
    open('https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml')
  end

  def self.currencies   #class method
    #new(fetch_list).currencies
    @rates.keys
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

  def self.get_rate(key)
    @rates[key]
  end
end



get '/' do
  erb :main, :locals => {:currencies => ConversionRate.currencies,
                         :amount => 0,
                         :original_currency => "EUR",
                         :target_currency => "EUR",
                         :target_amount => ""}
end

post '/converter' do
  
  amount = (params[:amount]).to_i
  rate1 = ConversionRate.get_rate(params[:original_currency])
  rate2 = ConversionRate.get_rate(params[:target_currency])
  
  target_amount = amount/rate1*rate2

  erb :main, :locals => {:currencies => ConversionRate.currencies,
                         :amount => params[:amount],
                         :original_currency => params[:original_currency],
                         :target_currency => params[:target_currency],
                         :target_amount => target_amount.to_s}
end
