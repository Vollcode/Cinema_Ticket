require 'spec_helper'
require 'capybara/rspec'


  describe "on the index page" do
    before(:each) do
      visit articles_path
    end


it "should list the article titles on the index" do
  visit articles_path
  @articles.each do |article|
    page.should have_content(article.title)
  end
end



#describe "the articles interface" do
#  before(:all) do
#    @articles = []
#    3.times{ @articles << Fabricate(:article) }
#  end
#
