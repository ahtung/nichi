class RenameFriendshipColumn < ActiveRecord::Migration
  def change
    rename_column :friendships, :friend_id, :contact_id
  end
end
