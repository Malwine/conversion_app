require 'sinatra'
require 'nokogiri'
require 'open-uri'

class ConversionRate

  def initialize(rate)
    @rate = rate
  end

  def get_rate
    @rate
  end

  @rates = {}
  
  def self.fetch_list

    ecb_rates = open('https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml')

    @rates["EUR"] = ConversionRate.new(1)
    doc = Nokogiri::XML(ecb_rates)
    doc.css('Cube[currency]').map do |cube|
      @rates[cube["currency"]] = ConversionRate.new(cube["rate"].to_f)
    end
  end

  def self.currencies
    fetch_list if @rates.empty?
    @rates.keys
  end 

  def self.get_rate(key)
    @rates[key]
  end

  def convert(amount,second_rate)
    amount/@rate*second_rate.get_rate
  end
end



get '/' do
  begin
    erb :main, :locals => {:currencies => ConversionRate.currencies,
                           :amount => 0,
                           :original_currency => "EUR",
                           :target_currency => "EUR",
                           :target_amount => "0.00"}
  rescue
    erb :error
  end
end

post '/' do
  
  amount = (params[:amount]).to_f
  rate1 = ConversionRate.get_rate(params[:original_currency])
  rate2 = ConversionRate.get_rate(params[:target_currency])

  target_amount = rate1.convert(amount,rate2)

  erb :main, :locals => {:currencies => ConversionRate.currencies,
                         :amount => params[:amount],
                         :original_currency => params[:original_currency],
                         :target_currency => params[:target_currency],
                         :target_amount => '%.2f' % [target_amount.round(2)]}
end
