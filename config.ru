require './conversion_app'
set :server, 'thin'
run Sinatra::Application
