require 'capybara/rspec'
require_relative '../conversion_app'

class ConversionRate 
end

Capybara.app = Sinatra::Application.new

describe 'the conversion app',:type => :feature do 

  it 'correctly convert EUR to USD when form is filled out' do 
    allow(ConversionRate).to receive(:rate).and_return(1.2)
  
    visit '/'
    select('EUR', :from => 'Original Currency')
    select('USD', :from => 'Target Currency')
    fill_in('Amount', :with => '10')
    click_button('Convert')
    
    expect(page).to have_content('USD 12')
  end

end