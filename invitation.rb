require 'rubygems'
require 'sinatra'
require 'pony'
require 'capybara/rspec'

SITE_TITLE = "Invitation Sender"
SITE_DESCRIPTION = "the best ticket sender service"

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
  forms
  if wrong_phone then redirect '/error' end
  if wrong_name then redirect '/error' end

  send_email

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

################################
def send_email
  Pony.mail(:subject=> 'Ticket Confirmation ' ,
      :to => "#{@email}",
      :html_body => "Thank you for buying through #{SITE_TITLE}, #{SITE_DESCRIPTION}. Please click on the following link to see the information you've selected. <a href='http://localhost:9393/form/infoticket/#{@name}/#{@email}/#{@phone}/#{@movie}/#{@price}'>Your Information</a> ")<br>
end

def wrong_phone
  @phone.size != 9
end

def wrong_name
 @name.size < 3 || @name.size > 20
end

def forms
  form_name
  form_email
  form_phone
  form_movie
  form_price
end

def form_name
  @name = params[:name]
end

def form_email
  @email = params[:email]
end

def form_phone
  @phone = params[:phone]
end

def form_movie
  @movie = params[:movie]
end

def form_price
  @price = params[:price]
end

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
