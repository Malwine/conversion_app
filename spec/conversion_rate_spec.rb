require_relative 'spec_helper'

describe ConversionRate do
  
  def xml_fixture 
    File.open(File.expand_path("../fixtures/eurofxref-daily.xml", __FILE__))
  end

  it "provides a list of currencies" do 
    conversionrate = ConversionRate.new(xml_fixture)
    expect(conversionrate.currencies).to include("HUF")
  end
  
  it "provides a list of currencies fetched from the ECB" do
    expect(ConversionRate).to receive(:fetch_list).and_return(xml_fixture)
    expect(ConversionRate.currencies).to include("HUF")
  end

end