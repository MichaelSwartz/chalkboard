require 'rails_helper'

feature 'create athlete' do
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    scenario 'authorized user creates athlete' do
      sign_in_as user

      visit new_athlete_path

      fill_in "First Name", with: "FirstName"
      fill_in "Last Name", with: "LastName"
      fill_in "Date of Birth", with: "11/11/1990"
      select 'Male', from: "Gender"

      click_on "Add Athlete"

      expect(page).to have_content("New athlete added")
      expect(page).to have_content("FirstName")
      expect(page).to have_content("LastName")
    end

    let(:user) { FactoryGirl.create(:user) }

    scenario 'user fails to create athlete with insufficient information' do
      sign_in_as user

      visit new_athlete_path

      click_on "Add Athlete"

      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content("Gender can't be blank")
      expect(page).to have_content("Date of birth can't be blank")
    end
  end

  context 'as a visitor user' do
    scenario 'visitor fails to create athlete' do
      visit athletes_path

      click_on "Add New Athlete"

      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end
end
