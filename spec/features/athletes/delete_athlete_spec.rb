require 'rails_helper'

feature 'delete athlete' do
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:athlete) { FactoryGirl.create(:athlete) }

    scenario 'authorized user deletes athlete' do
      sign_in_as user

      visit edit_athlete_path(athlete)

      click_on "Delete Athlete"
      # click_on "OK"

      expect(page).to have_content("Athlete deleted")
      expect(page).to_not have_content(athlete.last_name)
    end
  end

  context 'as a visitor user' do
    let(:athlete) { FactoryGirl.create(:athlete) }

    scenario 'visitor fails to delete athlete' do
      visit edit_athlete_path(athlete)

      expect(page).to_not have_content("Delete Athlete")
      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end
end
