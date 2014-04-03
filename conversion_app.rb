require 'sinatra'
require 'nokogiri'
require 'open-uri'

class ConversionRate

  @rates = {}
  
  def self.fetch_list
    ecb_rates = open('https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml')

    @rates["EUR"] = 1
    doc = Nokogiri::XML(ecb_rates)
    doc.css('Cube[currency]').map do |cube|
      @rates[cube["currency"]] = cube["rate"].to_f
    end
  end

  def self.currencies
    fetch_list if @rates.empty?
    @rates.keys
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
                         :target_amount => "0.00"}
end

post '/' do
  
  amount = (params[:amount]).to_f
  rate1 = ConversionRate.get_rate(params[:original_currency])
  rate2 = ConversionRate.get_rate(params[:target_currency])

  target_amount = amount/rate1*rate2

  erb :main, :locals => {:currencies => ConversionRate.currencies,
                         :amount => params[:amount],
                         :original_currency => params[:original_currency],
                         :target_currency => params[:target_currency],
                         :target_amount => '%.2f' % [target_amount.round(2)]}
end
