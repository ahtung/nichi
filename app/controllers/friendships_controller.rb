class FriendshipsController < ApplicationController
  def index
    @friendships = current_user.friendships
  end
end
