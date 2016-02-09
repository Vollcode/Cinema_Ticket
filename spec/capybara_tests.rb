require 'capybara/rspec'
require '../invitation'


Capybara.app = Sinatra::Application

describe "testing all routes: ", :type => :feature do
	it "from home page to form" do
		visit '/'

		click_link('invitationlogo')

		expect(page).to have_content('Nombre')
	end

		it "incorrect form fill results in error" do
		visit '/form'

		fill_in 'email',  :with => "daniel.ortiz.olivares@gmail.com"
  	fill_in 'name',   :with => "Daniel"
  	fill_in 'phone',  :with => "67283"
		click_button('Confirmar Reserva')

		expect(page).to have_content('incorrect')
		end

	it 'fill form and confirm' do
		visit '/form'

  	fill_in 'email',  :with => "daniel.ortiz.olivares@gmail.com"
  	fill_in 'name',   :with => "Daniel"
  	fill_in 'phone',  :with => "672831945"
		click_button ('Confirmar Reserva')

		expect(page).to have_content('Congratulations')
	end

	xit 'Invitation Confirmation through URL' do
		visit "/form/infoticket/Daniel/daniel.ortiz.olivares@gmail.com/672831945/Birdman/Entrada+con+gafas+3D:+9'50€"
		expect(page).to have_content('relevant')
	end
end
