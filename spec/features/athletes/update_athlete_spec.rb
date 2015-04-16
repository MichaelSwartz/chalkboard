require 'rails_helper'

feature 'update athlete' do
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:athlete) { FactoryGirl.create(:athlete) }

    scenario 'authorized user updates athlete' do
      sign_in_as user

      visit edit_athlete_path(athlete)

      fill_in "First Name", with: "FirstName"
      fill_in "Last Name", with: "LastName"
      fill_in "Date of Birth", with: "11/11/1990"
      fill_in "Team", with: "DMC"
      select 'Male', from: "Gender"

      click_on "Update Athlete"

      expect(page).to have_content("Athlete updated")
      expect(page).to have_content("FirstName")
      expect(page).to have_content("LastName")
      expect(page).to have_content("Male")
      expect(page).to have_content("DMC")
      expect(page).to have_content("1990")
    end

    scenario 'user fails to update athlete with insufficient information' do
      sign_in_as user

      visit edit_athlete_path(athlete)

      fill_in "First Name", with: ""
      fill_in "Last Name", with: ""
      fill_in "Date of Birth", with: ""
      select '', from: "Gender"

      click_on "Update Athlete"

      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content("Gender can't be blank")
      expect(page).to have_content("Date of birth can't be blank")
    end
  end

  context 'as a visitor user' do
    let(:athlete) { FactoryGirl.create(:athlete) }

    scenario 'visitor fails to update athlete' do
      visit athlete_path(athlete)

      click_on "Edit Athlete Information"

      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end
end
