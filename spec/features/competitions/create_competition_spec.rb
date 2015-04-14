require 'rails_helper'

feature 'create competition' do
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    # scenario 'authorized user creates competition' do
    #   sign_in_as user
    #
    #   visit new_competition_path
    #
    #   fill_in "Name", with: "2015 Nationals"
    #   select 'Male', from: "Gender"
    #   fill_in "Division", with: "Youth A"
    #   fill_in "Start Date", with: "07/25/2015"
    #   fill_in "End Date", with: "07/25/2015"
    #   fill_in "Gym", with: "Central Rock"
    #   fill_in "City", with: "Watertown"
    #   select 'MA', from: "State"
    #
    #   click_on "Create Competition"
    #
    #   expect(page).to have_content("New competition created")
    #   expect(page).to have_content("2015 Nationals")
    #   expect(page).to have_content('Male')
    #   expect(page).to have_content("Youth A")
    #   expect(page).to have_content("Central Rock")
    #   expect(page).to have_content('MA')
    #   expect(page).to have_content('Watertown')
    #   expect(page).to have_content('25')
    # end

    scenario 'user fails to create competition with insufficient information' do
      sign_in_as user

      visit new_competition_path

      click_on "Create Competition"

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Start date can't be blank")
    end
  end

  context 'as a visitor user' do
    scenario 'visitor fails to create competition' do
      visit competitions_path

      click_on "Create New Competition"

      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end
end
