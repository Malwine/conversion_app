require 'spec_helper'

describe 'the conversion app',:type => :feature do 

  it 'correctly convert EUR to USD when form is filled out' do 
    allow(ConversionRate).to receive(:rate).and_return(1.2)
    allow(ConversionRate).to receive(:currencies).and_return(["EUR","USD"])
  
    visit '/'
    select('EUR', :from => 'Original Currency')
    select('USD', :from => 'Target Currency')
    fill_in('Amount', :with => '10')
    click_button('Convert')
    
    expect(page).to have_content('USD 12')
  end

end