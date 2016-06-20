require 'rails_helper'

feature 'Login' do
  let!(:user) { create(:user, :auth) }

  context 'invalid user' do
    before { fill_login User.new(name: 'invalid@user.com', password: '123') }

    scenario 'stays at the root path' do
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'valid user' do
    before { fill_login user }

    scenario 'displays user taks page' do
      expect(current_path).to eq root_path

      expect(page).to have_content 'Listing Tasks'
    end
  end
end
