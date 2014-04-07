require_relative 'spec_helper'

describe ConversionRate do

  describe "class method .currencies" do

    it "returns a list of conversion rates" do
      expect(ConversionRate.currencies).to include("EUR")
    end
  end

  describe "class method .get_rate" do

    before do
      ConversionRate.fetch_list
    end

    it "returns an instance of ConversionRate" do
      expect(ConversionRate.get_rate("USD")).to be_a ConversionRate
    end
  end

  describe "initialize" do
    it "takes a rate" do
      expect(ConversionRate.new(1.5).get_rate).to eql 1.5
    end
  end

  describe "convert" do
    it "converts correctly" do
      eur = ConversionRate.new(1)
      usd = ConversionRate.new(1.3)
      expect(eur.convert(10,usd)).to eql 13.0
    end
  end


end