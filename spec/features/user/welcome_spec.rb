require 'rails_helper'

RSpec.describe 'User', type: :feature, js: true do
  let(:user) { create(:user) }

  it 'should be able to see events' do
    login_as user, scope: :user
    visit root_path
    click_on 'Events'
    expect(page).to have_content('List Events')
  end

  it 'should be able to create event' do
    login_as user, scope: :user
    visit root_path
    click_on 'New'
    expect(page).to have_content('New Event')
  end
end
