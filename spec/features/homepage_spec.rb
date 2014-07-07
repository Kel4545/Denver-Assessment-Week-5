require "spec helper"

feature "Homepage" do
  scenario "When logged in a user sees the homepage, can login, see contacts and logout" do
    visit "/"

    expect (page).to have_content "Contacts"
    click_button "Login"
    fill_in("name")
    fill_in("Password")
    expect(page).to have_content "Welcome, User"
    click_button "Logout"
    expect(page).to have_content "Log In to Me!"
  end
end