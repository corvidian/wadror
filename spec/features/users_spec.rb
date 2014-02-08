require 'spec_helper'
include OwnTestHelper

describe 'User' do
  let!(:user) { FactoryGirl.create :user }
  let(:brewery) { FactoryGirl.create :brewery }

  describe 'who has signed up' do
    it 'can signin with right credentials' do
      sign_in(username: 'Pekka', password: 'Foobar1')

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it 'is redirected back to signin form if wrong credentials given' do
      sign_in(username: 'Pekka', password: 'Foobar')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end
  end

  describe 'who has signed in' do
    before :each do
      sign_in(username: 'Pekka', password: 'Foobar1')
    end

    describe 'and has many ratings' do
      before :each do
        create_beers_with_ratings(10, 20, 15, 7, 9, user, style:'IPA', brewery:brewery)
      end

      it 'has ratings listed' do
        visit user_path(user)
        expect(page).to have_content('has made 5 ratings')
      end

      it 'has only own ratings listed' do
        other_user = FactoryGirl.create :user, username: 'Tapsa'
        create_beers_with_ratings(10, 20, 15, 7, 9, other_user)

        visit user_path(user)
        expect(page).to have_content('has made 5 ratings')
      end

      it 'has a favorite style listed' do
        visit user_path(user)
        save_and_open_page
        expect(page).to have_content('favorite style')
      end
      it 'has a favorite brewery listed' do
        visit user_path(user)
        expect(page).to have_content('favorite brewery')
      end

    end

    describe 'and without ratings' do
      it 'does not have a favorite style listed' do
        visit user_path(user)
        expect(page).not_to have_content('favorite style')
      end

      it 'does not have a favorite brewery listed' do
        visit user_path(user)
        expect(page).not_to have_content('favorite brewery')
      end
    end
  end

  it 'when signed up with good credentials, is added to the system' do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
end