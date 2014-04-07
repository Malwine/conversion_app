require_relative 'spec_helper'

describe ConversionRate do

  it "provides a list of currencies" do 
    expect(ConversionRate.currencies).to include("HUF")
  end

end