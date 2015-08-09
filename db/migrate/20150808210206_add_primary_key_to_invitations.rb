class AddPrimaryKeyToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :id, :primary_key
  end
end
