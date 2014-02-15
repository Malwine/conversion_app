require 'capybara/rspec'
require_relative '../conversion_app'

Capybara.app = Sinatra::Application.new