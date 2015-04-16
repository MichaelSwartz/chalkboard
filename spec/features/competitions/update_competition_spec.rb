# require 'rails_helper'
#
# feature 'update competition' do
#   context 'as an authorized user' do
#     let(:user) { FactoryGirl.create(:user) }
#     let(:competition) { FactoryGirl.create(:competition) }
#
#     scenario 'authorized user updates competition' do
#       sign_in_as user
#
#       visit edit_competition_path(competition)
#
#       fill_in "First Name", with: "FirstName"
#       fill_in "Last Name", with: "LastName"
#       fill_in "Date of Birth", with: "11/11/1990"
#       fill_in "Team", with: "DMC"
#       select 'Male', from: "Gender"
#
#       click_on "Update competition"
#
#       expect(page).to have_content("Competition updated")
#       expect(page).to have_content("FirstName")
#       expect(page).to have_content("LastName")
#       expect(page).to have_content("Male")
#       expect(page).to have_content("DMC")
#       expect(page).to have_content("1990")
#     end
#
#     scenario 'user fails to update competition with insufficient information' do
#       sign_in_as user
#
#       visit edit_competition_path(competition)
#
#       fill_in "First Name", with: ""
#       fill_in "Last Name", with: ""
#       fill_in "Date of Birth", with: ""
#       select '', from: "Gender"
#
#       click_on "Update competition"
#
#       expect(page).to have_content("First name can't be blank")
#       expect(page).to have_content("Last name can't be blank")
#       expect(page).to have_content("Gender can't be blank")
#       expect(page).to have_content("Date of birth can't be blank")
#     end
#   end
#
#   context 'as a visitor' do
#     let(:competition) { FactoryGirl.create(:competition) }
#
#     scenario 'visitor fails to update competition' do
#       visit edit_competition_path(competition)
#
#       expect(page).to_not have_link("Update Competition")
#       expect(page).to have_content("You need to sign in or sign up before continuing")
#     end
#   end
#
#   context 'as a non-owner user' do
#     let(:competition) { FactoryGirl.create(:competition) }
#
#     scenario 'other user fails to update competition' do
#       visit edit_competition_path(competition)
#
#       expect(page).to_not have_link("Update Competition")
#       expect(page).to have_content("TK")
#     end
#   end
# end
