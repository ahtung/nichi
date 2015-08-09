class AddIndexes < ActiveRecord::Migration
  def change
    add_index(:invitations, :user_id)
    add_index(:invitations, :event_id)

    add_index(:events, :owner_id)

    add_index(:friendships, :user_id)
    add_index(:friendships, :contact_id)
  end
end
