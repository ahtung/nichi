require 'rails_helper'

RSpec.describe 'User', type: :feature, js: true do
  let(:event) { build(:event) }
  let(:user) { create(:user, contacts: create_list(:user,2)) }

  xit 'should be able to create an event' do
    login_as user, scope: :user
    visit root_path

    click_on 'New'
    fill_in 'event_name', with: event.name

    click_on 'Who'
    binding.pry
    first('#event_user_ids').find("option[value='#{user.contacts.first.id}']").select_option

    click_on 'When'
    # TODO

    click_on 'Start'
    click_on 'Save'

    expect(page).to have_content(event.name)
  end
end
