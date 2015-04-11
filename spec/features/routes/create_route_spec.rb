require 'rails_helper'

feature 'create route' do
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:round) { FactoryGirl.create(:round) }

    scenario 'authorized user creates route' do
      sign_in_as user

      visit new_round_route_path

      fill_in "Name", with: "Black 1"
      fill_in "Round", with: "Black 1"
      fill_in "DOB", with: "11/11/1990"

      click_on "Add Route"

      visit athletes_path
      expect(page).to have_content("New Athlete Added")
      expect(page).to have_content(last)
      expect(page).to have_content(first)
    end
  end

  scenario 'visitor fails to create athlete' do

    visit new_athlete_path

    fill_in "First Name", with: "FirstName"
    fill_in "Last Name", with: "LastName"
    fill_in "DOB", with: "11/11/1990"

    click_on "Add Route"

    expect(page).to have_content("You must sign in to add routes")
  end
end
end
