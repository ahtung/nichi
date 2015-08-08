require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let(:events) { create_list(:event, 1) }
  let(:user) { create(:user, events: events) }

  xit 'should be able to create an event' do
    login_as user, scope: :user
    visit root_path
    click_on 'New'

  end
end
