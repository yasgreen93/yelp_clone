require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant (when signed in)' do
      sign_up_user1
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up_create_restaurant
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'user cannot add a restaurant when not signed in' do
      visit '/'
      click_link 'Add a restaurant'
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(page).to have_content('Log in')
    end
  end

  context 'viewing restaurants' do
    let!(:kfc){Restaurant.create(name:'KFC')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before { Restaurant.create name: 'KFC' }

    scenario 'let a user edit a restaurant' do
      sign_up_user1
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'user cannot edit a restaurant they did not create' do
      sign_up_create_restaurant
      click_link 'Sign out'
      sign_up_user2
      click_link 'Edit KFC'
      expect(page).to have_content('Cannot edit a restaurant you did not create')
      expect(current_path).to eq('/')
    end



  end

  context 'deleting restaurants' do
    let!(:kfc) {Restaurant.create name: 'KFC'}

    before do
      kfc.reviews.create(thoughts: "so so", rating: 3)
    end

    scenario 'removes a restaurant and associated reviews when a user clicks a delete link' do
      sign_up_user1
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context 'an invalid restaurant' do
    it 'does not let you submit a name that is too short' do
      sign_up_user1
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end

  context 'validation duplicate restaurants' do
    it 'is not valid unless it has a unique name' do
      Restaurant.create(name: 'nice restaurant')
      restaurant = Restaurant.new(name: 'nice restaurant')
      expect(restaurant).to have(1).error_on(:name)
    end
  end
end
