require 'rails_helper'

feature 'Record Attempt' do
  let(:user) { FactoryGirl.create(:user) }
  let!(:athlete) { FactoryGirl.create(:athlete) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:comp) { FactoryGirl.create(:competition, user: user) }
  let!(:bib) { FactoryGirl.create(:bib, athlete: athlete, competition: comp)}
  let(:round) { FactoryGirl.create(:round, competition: comp) }
  let(:route) { FactoryGirl.create(:route, round: round, max_score: 30) }

  context 'as an authorized user' do
    scenario 'authorized user records attempt' do
      sign_in_as user
      visit route_path(route)

      select athlete.name_last_first, from: "Athlete"
      fill_in "Score", with: "25.45"

      click_on "Submit"

      expect(page).to have_content("Attempt recorded")
      expect(page).to have_content(athlete.last_name)
      expect(page).to have_content("25.45")
    end

    scenario 'user fails to record attempt with insufficient info' do
      sign_in_as user
      visit route_path(route)

      select '', from: "Athlete"

      click_on "Submit"

      expect(page).to have_content("Athlete can't be blank.")
      expect(page).to have_content("Score can't be blank.")
    end

    scenario 'user fails to record attempt with invalid input' do
      sign_in_as user
      visit route_path(route)

      select athlete.name_last_first, from: "Athlete"
      fill_in "Score", with: "Black 50"

      click_on "Submit"

      expect(page).to have_content("Score is not a number")
    end
  end

  context 'as a visitor user' do
    scenario 'visitor fails to record attempt' do
      visit route_path(route)

      expect(page).to_not have_link("Record Attempt")
    end
  end

  context 'as a non-owner user' do
    scenario 'non-owner fails to record attempt' do
      sign_in_as user2
      visit route_path(route)

      expect(page).to_not have_link("Record Attempt")
    end
  end
end
