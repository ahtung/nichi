require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let(:event) { build(:event) }
  let(:user) { create(:user) }

  it 'should be able to create an event' do
    login_as user, scope: :user
    visit root_path
    click_on 'New'
    fill_in 'event_name', with: event.name
    click_on 'Save'
    expect(page).to have_content(event.name)
  end
end
