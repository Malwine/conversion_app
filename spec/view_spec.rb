require 'spec_helper'

describe "view spec"  do
  def app
    Sinatra::Application.new!
  end

  def output
    Capybara.string(app.erb(:main, :locals => {:currencies => ["EUR","USD"] }))
  end

  context "Currency Dropdowns" do
    it "should have a dropdown with a list of original currencies" do 
      dropdown = output.find("#original_currency")
      
      expect(dropdown.all("option").size).to eq 2
      expect(dropdown.find("option[value=EUR]")).to have_content("EUR")
      expect(dropdown.find("option[value=USD]")).to have_content("USD")
    end
    
    it "should have a dropdown with a list of target currencies"do
      dropdown = output.find("#target_currency")
      expect(dropdown.all("option").size).to eq 2
      expect(dropdown.find("option[value=EUR]")).to have_content("EUR")
    end
  end 


end