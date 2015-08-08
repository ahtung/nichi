require 'rails_helper'

RSpec.describe 'Guest', type: :feature do
  let(:user) { create(:user) }

  it 'should be able to login' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    expect(page).to have_content('Sign Out')
  end
end
