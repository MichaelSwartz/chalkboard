require 'rails_helper'

feature 'create round' do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:comp) { FactoryGirl.create(:competition, user: user) }

  context 'as an authorized user' do
    scenario 'user who owns comp creates round' do
      sign_in_as user
      visit competition_path(comp)

      click_on "Add Round"

      fill_in "Name", with: "Qualifier"
      fill_in "Round Number", with: "1"

      click_on "Create Round"

      expect(page).to have_content("New round created")
      expect(page).to have_content('1')
      expect(page).to have_content('Qualifier')
    end

    scenario 'user fails to create round with insufficient information' do
      sign_in_as user
      visit competition_path(comp)

      click_on "Add Round"

      click_on "Create Round"

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Number can't be blank")
    end
  end

  context 'as a visitor user' do
    scenario 'visitor fails to create round' do
      visit competition_path(comp)

      expect(page).to_not have_content("Add Round")
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
