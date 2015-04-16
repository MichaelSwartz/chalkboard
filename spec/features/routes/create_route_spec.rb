require 'rails_helper'

feature 'create route' do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:comp) { FactoryGirl.create(:competition, user: user) }
  let(:round) { FactoryGirl.create(:round, competition: comp) }

  context 'as an authorized user' do
    scenario 'authorized user creates route' do
      sign_in_as user

      visit new_round_route_path(round)

      fill_in "Name", with: "Black 1"
      fill_in "Maximum Score", with: "50"

      click_on "Create Route"

      expect(page).to have_content("New Athlete Added")
      expect(page).to have_content(last)
      expect(page).to have_content(first)
    end
  end

  context 'as a visitor user' do
    scenario 'visitor fails to create athlete' do

      visit new_athlete_path

      fill_in "First Name", with: "FirstName"
      fill_in "Last Name", with: "LastName"
      fill_in "DOB", with: "11/11/1990"

      click_on "Add Route"

      expect(page).to have_content("You must sign in to add routes")
    end
  end

  context 'as a non-owner user' do
    scenario 'non-owner fails to create round' do
      sign_in_as user2
      visit competition_path(comp)

      expect(page).to_not have_link("Add Round")

      visit new_competition_round_path(comp)

      expect(page).to have_content("Access restricted to competition creator")
    end
  end
end
