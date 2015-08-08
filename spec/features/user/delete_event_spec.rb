require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let(:events) { create_list(:event, 1) }
  let(:user) { create(:user, events: events) }

  it 'should be able to delete event' do
    login_as user, scope: :user
    visit events_path
    click_on 'Delete'
    expect(page).not_to have_content(events.first.name)
  end
end
