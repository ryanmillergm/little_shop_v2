require 'rails_helper'

RSpec.describe "As a visitor on the index page" do
  describe "when I click on the register link in the nav bar" do
    describe "I see a form with the following data" do
      before :each do
        visit root_path
      end

      it "I enter name, address, city, state, zip, email, password and confirmation field for password, saves my info into db and logs me in as a user" do
        expect(page).to have_link("Register as User")

        click_link "Register as User"

        expect(current_path).to eq(new_user_path)

        fill_in "Name", with: "Bob Dylan"
        fill_in "Email", with: "TheBob@email.com"
        fill_in "Address", with: "123 Highway 51"
        fill_in "City", with: "Tombstone"
        fill_in "State", with: "Arizona"
        fill_in "Zip", with: "84029"
        fill_in "Password", with: "pass123"
        fill_in "Password confirmation", with: "pass123"
        click_on "Create User"

        new_user = User.last

        expect(current_path).to eq(user_path)
        expect(page).to have_content("Congratulations #{new_user.name}! You are now registered and logged in.")
      end
      it "when I fill out missing name for registration page I am returned to the registration page" do
        visit new_user_path

        fill_in "Email", with: "TheBob@email.com"
        fill_in "Address", with: "123 Highway 51"
        fill_in "City", with: "Tombstone"
        fill_in "State", with: "Arizona"
        fill_in "Zip", with: "84029"
        fill_in "Password", with: "pass123"
        fill_in "Password confirmation", with: "pass123"
        click_on "Create User"

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Unable to register user. Missing required fields")
    end
      it "when I fill out missing email registration page I am returned to the registration page" do
        visit new_user_path

        fill_in "Name", with: "Bob Dylan"

        fill_in "Address", with: "123 Highway 51"
        fill_in "City", with: "Tombstone"
        fill_in "State", with: "Arizona"
        fill_in "Zip", with: "84029"
        fill_in "Password", with: "pass123"
        fill_in "Password confirmation", with: "pass123"
        click_on "Create User"

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Unable to register user. Missing required fields")
      end
      it "when I fill out missing address registration page I am returned to the registration page" do
        visit new_user_path

        fill_in "Name", with: "Bob Dylan"
        fill_in "Email", with: "TheBob@email.com"

        fill_in "City", with: "Tombstone"
        fill_in "State", with: "Arizona"
        fill_in "Zip", with: "84029"
        fill_in "Password", with: "pass123"
        fill_in "Password confirmation", with: "pass123"
        click_on "Create User"

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Unable to register user. Missing required fields")
      end
      it "when I fill out missing city registration page I am returned to the registration page" do
        visit new_user_path

        fill_in "Name", with: "Bob Dylan"
        fill_in "Email", with: "TheBob@email.com"
        fill_in "Address", with: "123 Highway 51"

        fill_in "State", with: "Arizona"
        fill_in "Zip", with: "84029"
        fill_in "Password", with: "pass123"
        fill_in "Password confirmation", with: "pass123"
        click_on "Create User"

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Unable to register user. Missing required fields")
      end
      it "when I fill out missing state registration page I am returned to the registration page" do
        visit new_user_path

        fill_in "Name", with: "Bob Dylan"
        fill_in "Email", with: "TheBob@email.com"
        fill_in "Address", with: "123 Highway 51"
        fill_in "City", with: "Tombstone"

        fill_in "Zip", with: "84029"
        fill_in "Password", with: "pass123"
        fill_in "Password confirmation", with: "pass123"
        click_on "Create User"

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Unable to register user. Missing required fields")
      end
      it "when I fill out missing zip registration page I am returned to the registration page" do
        visit new_user_path

        fill_in "Name", with: "Bob Dylan"
        fill_in "Email", with: "TheBob@email.com"
        fill_in "Address", with: "123 Highway 51"
        fill_in "City", with: "Tombstone"
        fill_in "State", with: "Arizona"

        fill_in "Password", with: "pass123"
        fill_in "Password confirmation", with: "pass123"
        click_on "Create User"

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Unable to register user. Missing required fields")
      end
      it "when I fill out missing password registration page I am returned to the registration page" do
        visit new_user_path

        fill_in "Name", with: "Bob Dylan"
        fill_in "Email", with: "TheBob@email.com"
        fill_in "Address", with: "123 Highway 51"
        fill_in "City", with: "Tombstone"
        fill_in "State", with: "Arizona"
        fill_in "Zip", with: "84029"


        click_on "Create User"

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Unable to register user. Missing required fields")
      end
      it "If I register with an email already in use, I am returned to form and the form has all data expect email and password and see flash message saying email is in use" do
        user = create(:user, email: "email1@gmail.com")

        visit new_user_path

        fill_in "Name", with: "Bob Dylan"
        fill_in "Email", with: "email1@gmail.com"
        fill_in "Address", with: "123 Highway 51"
        fill_in "City", with: "Tombstone"
        fill_in "State", with: "Arizona"
        fill_in "Zip", with: "84029"
        fill_in "Password", with: "pass123"
        fill_in "Password confirmation", with: "pass123"
        click_on "Create User"

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Email address is already in use")

        fill_in "Email", with: "new_email@gmail.com"
        fill_in "Password", with: "pass123"
        fill_in "Password confirmation", with: "pass123"
        click_on "Create User"

        new_user = User.last

        expect(current_path).to eq(user_path)
      end
    end
  end
end
