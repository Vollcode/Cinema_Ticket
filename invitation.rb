require 'rubygems'
require 'sinatra'
require 'pony'
require 'capybara/rspec'

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
  @name = params[:name]
  @email = params[:email]
  @phone = params[:phone]
  @movie = params[:movie]
  @price = params[:price]
if @phone.size != 9 then redirect '/error' end
if @name.size < 3 then redirect '/error' end
  Pony.mail(:subject=> 'Ticket Confirmation ' ,
    	:to => "#{@email}",
    	:html_body => "Thank you for buying through Invitation Sender. Please click on the following link to see the information you've selected. <a href='http://localhost:9393/form/infoticket/#{@name}/#{@email}/#{@phone}/#{@movie}/#{@price}'>Your Information</a> ")


  erb :index, :locals => {'name' => @name, 'email' => @email, 'phone' => @phone, 'movie' => @movie, 'price' => @price}

end

get '/form/infoticket/:name/:email/:phone/:movie/:price' do
  @name = params[:name].gsub('+',' ')
  @email = params[:email].gsub('+',' ')
  @phone = params[:phone].gsub('+',' ')
  @movie = params[:movie].gsub('+',' ')
  @price = params[:price].gsub('+',' ')

  erb :confirm
end

not_found do
	halt 404, "Don't go in there"
end
