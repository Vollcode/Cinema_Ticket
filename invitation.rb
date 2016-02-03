require 'rubygems'
require 'sinatra'
require 'pony'

SITE_TITLE = "Invitation Sender"
SITE_DESCRIPTION = "The best ticket sender service"	

	Pony.options = {
      :via => :smtp,
      :via_options => {
        :address => 'smtp.sendgrid.net',
        :port => '587',
        :domain => 'heroku.com',
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :authentication => :plain,
        :enable_starttls_auto => true
      }
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

post '/form' do
  ticket_id = Time.now.to_i
  
  @name = params[:name]
  @email = params[:email]
  @phone = params[:phone]
  @movie = params[:movie]
  @price = params[:price]

  Pony.mail(:subject=> 'Ticket Confirmation ' , 
    	:to => "#{@email}", 
    	:body => "Thank you for buying through Invitation Sender. Your ticket code is #{ticket_id}" )
 
#  erb :index, :locals => {'name' => @name, 'email' => @email, 'phone' => @phone, 'movie' => @movie, 'price' => @price}

end

not_found do 
	halt 404, 'Por ahí no sigas'
end
