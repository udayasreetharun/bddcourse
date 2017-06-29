require 'rails_helper'
RSpec.describe "Articles", type: :request do
before do
	@john = User.create(email: "john@example.com", password: "password") 
	@fred = User.create(email: "fred@example.com", password: "password")
@article = Article.create!(title: "Title one", body: "Body of article one")
end

describe 'GET /articles/:id/edit' do 
context 'with non-signed in user' do
before { get "/articles/#{@article.id}/edit" }
it "redirects to the signin page" do 
expect(response.status).to eq 302
flash_message = "You need to sign in or sign up before continuing"
expect(flash[:alert]).to eq flash_message
end 
end
context 'with signed in users who are non-owners' do 
before do
login_as(@fred)
get "/articles/#{@article.id}/edit" 
end
it "redirects to the home page" do 
expect(response.status).to eq 302
flash_message = "You can only edit your own article." 
expect(flash[:alert]).to eq flash_message
end 
end
end
context 'with signed in user as owner' do 
before do
login_as(@john)
get "/articles/#{@article.id}/edit" 
end
it "successfully edits article" do 
expect(response.status).to eq 200
end 
end
end

