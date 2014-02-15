require 'spec_helper'

describe "view spec"  do
  def app
    Sinatra::Application.new!
  end

  context "Original Currency" do
    it "should have a dropdown with a list of currencies" do 
      output = Capybara.string(app.erb(:main, :locals => {:currencies => ["EUR","USD"] }))
      dropdown = output.find("#original_currency")
      
      expect(dropdown.all("option").size).to eq 2
      expect(dropdown.find("option[value=EUR]")).to have_content("EUR")
      expect(dropdown.find("option[value=USD]")).to have_content("USD")

    end
  end 

end