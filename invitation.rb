require 'rubygems'
require 'sinatra'
require 'pony'

SITE_TITLE = "Invitation_Sender"
SITE_DESCRIPTION = "The best ticket sender service"	

    Pony.options = {
      :via => :smtp,
      :via_options => {
        :address => 'smtp.sendgrid.net',
        :port => '587',
        :domain => 'myapp.com',
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :authentication => :plain,
        :enable_starttls_auto => true
      }

get '/' do
 erb :logo
end

get '/form' do
  erb :form
end

get '/error' do
  erb :error
end

get '/confirm' do
 erb :confirm
end

post '/form' do
  @name = params[:name]
  @email = params[:email]
  @phone = params[:phone]
  @movie = params[:movie]
  @ticket = params[:ticket]

  erb :index, :locals => {'name' => @name, 'email' => @email, 'phone' => @phone, 'movie' => @movie, 'ticket' => @ticket}

end

not_found do 
	halt 404, 'Por ahí no sigas'
end
