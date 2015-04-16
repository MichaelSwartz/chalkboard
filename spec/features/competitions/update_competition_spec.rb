require 'rails_helper'

feature 'edit competition' do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:competition) { FactoryGirl.create(:competition, user: user) }

  context 'as owner' do
    scenario 'owner edits competition' do
      sign_in_as user
      visit edit_competition_path(competition)

      fill_in "Name", with: "2015 Nationals"
      select 'Male', from: "Gender"
      fill_in "Division", with: "Youth A"
      fill_in "Start Date", with: Date.new(2015, 07, 25)
      fill_in "End Date", with: Date.new(2015, 07, 26)
      fill_in "Gym", with: "Central Rock"
      fill_in "City", with: "Watertown"
      select 'MA', from: "State"

      click_on "Update Competition"

      expect(page).to have_content("Competition updated")
      expect(page).to have_content("2015 Nationals")
      expect(page).to have_content('Male')
      expect(page).to have_content("Youth A")
      expect(page).to have_content("Central Rock")
      expect(page).to have_content('MA')
      expect(page).to have_content('Watertown')
      expect(page).to have_content('25')
      expect(page).to have_content('26')
    end

    scenario 'owner fails to update competition with insufficient info' do
      sign_in_as user
      visit edit_competition_path(competition)

      fill_in "Name", with: ""
      fill_in "Start Date", with: ""

      click_on "Update Competition"

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Start date can't be blank")
    end
  end

  context 'as a visitor user' do
    scenario 'visitor fails to edit competition' do
      visit edit_competition_path(competition)

      expect(page).to_not have_link("Update Competition")
      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end

  context 'as a non-owner user' do
    scenario 'non-owner fails to delete competition' do
      sign_in_as user2
      visit edit_competition_path(competition)

      expect(page).to_not have_link("Update Competition")
      expect(page).to have_content("Access restricted to competition creator")
    end
  end
end
