require 'rails_helper'

RSpec.describe 'User', type: :feature, js: true do
  let(:invitations) { create_list(:invitation, 1) }
  let(:user) { create(:user, invitations: invitations) }

  it 'should be able to reject invitation' do
    login_as user, scope: :user
    visit invitations_path
    first("li#invitation-#{invitations.first.id} div").click
    click_on 'Reject'
    expect(page).not_to have_content(invitations.first.event.name)
  end
end
