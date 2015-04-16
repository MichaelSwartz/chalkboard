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

      expect(page).to have_content("New route created")
      expect(page).to have_content("Black 1")
    end

    scenario 'user fails to create route with insufficient info' do
      sign_in_as user
      visit new_round_route_path(round)

      click_on "Create Route"

      expect(page).to have_content("Name can't be blank.")
      expect(page).to have_content("Max score can't be blank.")
    end

    scenario 'user fails to create route with invalid input' do
      sign_in_as user
      visit new_round_route_path(round)

      fill_in "Name", with: "Black 1"
      fill_in "Maximum Score", with: "Black 50"

      click_on "Create Route"

      expect(page).to have_content("Max score is not a number")
    end
  end

  context 'as a visitor user' do
    scenario 'visitor fails to create route' do
      visit round_path(round)

      expect(page).to_not have_link("Add Route")

      visit new_round_route_path(round)

      expect(page).to have_content("You need to sign in or sign up before continuing")
      expect(page).to_not have_content("Add Route")
    end
  end

  context 'as a non-owner user' do
    scenario 'non-owner fails to create route' do
      sign_in_as user2
      visit round_path(round)

      expect(page).to_not have_link("Add Route")

      visit new_round_route_path(round)

      expect(page).to have_content("Access restricted to competition creator")
      expect(page).to_not have_link("Create Route")
    end
  end
end
