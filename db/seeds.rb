event_count = rand(2...10)
invitation_count = rand(1...3)
friendship_count = rand(3...5)

Event.delete_all
Invitation.delete_all
Friendship.delete_all

FactoryGirl.create_list(:event, event_count, users: FactoryGirl.create_list(:user, rand(1...3)), owner: User.first)
FactoryGirl.create_list(:invitation, invitation_count, user: User.first)

FactoryGirl.create_list(:user, 5).each do |user|
  FactoryGirl.create(:friendship, user: User.first, contact: user)
end
