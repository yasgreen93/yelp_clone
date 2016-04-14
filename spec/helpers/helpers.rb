def sign_up_user1
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'user1@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def sign_up_user2
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'user2@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def sign_up_create_restaurant
  sign_up_user1
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'KFC'
  click_button 'Create Restaurant'
end
