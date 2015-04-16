require 'rails_helper'

feature 'delete competition' do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:competition) { FactoryGirl.create(:competition, user: user) }

  context 'as owner' do
    scenario 'owner deletes competition' do
      sign_in_as user
      visit edit_competition_path(competition)

      click_on "Delete Competition"

      expect(page).to have_content("Competition deleted")
      expect(page).to_not have_content(competition.name)
    end
  end

  context 'as a visitor user' do
    scenario 'visitor fails to delete competition' do
      visit edit_competition_path(competition)

      expect(page).to_not have_link("Delete Competition")
      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end

  context 'as a non-owner user' do
    scenario 'non-owner fails to delete competition' do
      sign_in_as user2
      visit edit_competition_path(competition)

      expect(page).to_not have_link("Delete Competition")
      expect(page).to have_content("Access restricted to competition creator")
    end
  end
end
