require 'rack/test'
require 'rspec'
require 'capybara'


ENV['RACK_ENV'] = 'test'

require File.expand_path './invitation.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

# For RSpec 2.x and 3.x
RSpec.configure { |c| c.include RSpecMixin }

# heroku git:remote -a vast-savannah-96984
# export SENDGRID_USERNAME=app47023151@heroku.com
# export SENDGRID_PASSWORD=vhnoc44z5715
