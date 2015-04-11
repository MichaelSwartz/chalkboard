require 'rails_helper'

feature 'create athlete' do
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    scenario 'authorized user creates athlete' do
      sign_in_as user

      visit new_athlete_path

      fill_in "First Name", with: "FirstName"
      fill_in "Last Name", with: "LastName"
      fill_in "DOB", with: "11/11/1990"

      click_on "Add Athlete"

      visit athletes_path
      expect(page).to have_content("New Athlete Added")
      expect(page).to have_content("FirstName")
      expect(page).to have_content("LastName")
    end
  end

  context 'as a visitor user' do
    scenario 'visitor fails to create athlete' do

      visit new_athlete_path

      fill_in "First Name", with: "FirstName"
      fill_in "Last Name", with: "LastName"
      fill_in "DOB", with: "11/11/1990"

      click_on "Add Athlete"

      expect(page).to have_content("You must sign in to add athletes")
    end
  end
end
