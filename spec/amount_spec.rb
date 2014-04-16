require_relative 'spec_helper'

describe Amount do

  describe "convert" do
    it "does convert correctly" do

      amount = Amount.new(10)
      eur = ConversionRate.new(1)
      usd = ConversionRate.new(1.3)
      expect(amount.convert(eur,usd)).to eql 13.0
    end
  end
end