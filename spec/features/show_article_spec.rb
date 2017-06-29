require "rails_helper"
RSpec.feature "Showing an Article" do
before do
	@john=User.create(email:"john@example.com",password:"password")
		@fred=User.create(email:"fred@example.com",password:"password")
@article = Article.create(title: "The first article",
body: "Lorem ipsum dolor sit amet, consectetur.",user: @john) 
end

scenario "A non-user signed in then lists all articles" do
visit "/"
click_link @article.title
expect(page).to have_content(@article.title) 
expect(page).to have_content(@article.body) 
expect(current_path).to eq(article_path(@article))
expect(page).not_to have_link("Edit article")
expect(page).not_to have_link("Delete article")
end
scenario "A user signed in then lists all articles" do
	login_as (@fred)
visit "/"

click_link @article.title
expect(page).to have_link("Edit article")
expect(page).to have_link("Delete article")
end
scenario "A signed in owner sees both links" do 
login_as(@john)
visit "/"
click_link @article.title
expect(page).to have_content(@article.title) 
expect(page).to have_content(@article.body) 
expect(current_path).to eq(article_path(@article))
expect(page).to have_link("Edit Article")
expect(page).to have_link("Delete Article") 
end
end