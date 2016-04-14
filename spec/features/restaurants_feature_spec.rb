require "rails_helper"
require "pry"

feature "restaurants" do
  context "no restaurants have been added" do
    scenario "should display a prompt to add a restaurant" do
      visit "/restaurants"
      expect(page).to have_content "No restaurants yet"
      expect(page).to have_link "Add a restaurant"
    end
  end

  context 'restaurants have been added' do
    before do
      sign_up
      create_restaurant
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    context 'while signed in' do
      before do
        sign_up
      end

      scenario 'prompts user to fill out a form, then displays the new restaurant' do
        create_restaurant
        expect(page).to have_content 'KFC'
        expect(current_path).to eq '/restaurants'
      end

      context 'an invalid restaurant' do
        scenario 'does not let you submit a name that is too short' do
          visit '/restaurants'
          click_link 'Add a restaurant'
          fill_in 'Name', with: 'KF'
          click_button 'Create Restaurant'
          expect(page).not_to have_css 'h2', text: 'kf'
          expect(page). to have_content 'error'
          expect(current_path).to eq '/restaurants'
        end
      end
    end

    context 'while signed out' do
      scenario 'prompts user to fill out a form, then raises error'  do
        visit '/restaurants'
        expect{ click_link 'Add a restaurant' }.to change{Restaurant.count}.by 0
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  context 'viewing restaurants' do

    before do
      sign_up
      create_restaurant
    end

    scenario 'lets a user view a restaurant' do
     visit '/restaurants'
     click_link 'KFC'
     expect(page).to have_content 'KFC'
     expect(current_path).to eq "/restaurants/#{Restaurant.first.id}"
    end
  end

  context 'editing restaurants' do
    # before do
    #   sign_up
    #   create_restaurant
    # end

    scenario 'let a user edit a restaurant' do
      sign_up
      create_restaurant
     click_link 'Edit KFC'
     fill_in 'Name', with: 'Kentucky Fried Chicken'
     click_button 'Update Restaurant'
     expect(page).to have_content 'Kentucky Fried Chicken'
     expect(current_path).to eq '/restaurants'
    end

    scenario 'only lets users edit their own restaurant' do
      sign_up
      create_restaurant
      click_link 'Sign out'
      sign_up_2
      click_link 'Edit KFC'
      click_button 'Update Restaurant'
      expect(page).to have_content "You cannot edit this restaurant"
    end
  end

  context 'deleting restaurants' do
    before do
      sign_up
      create_restaurant
    end

    scenario 'let a user delete a restaurant' do
     click_link 'Delete'
     expect(page).not_to have_content 'Kentucky Fried Chicken'
     expect(current_path).to eq '/restaurants'
    end

    scenario 'only lets users delete their own restaurant' do
     click_link 'Sign out'
     sign_up_2
     click_link 'Delete'
     expect(page).to have_content "You cannot delete this restaurant"
    end
  end



end
