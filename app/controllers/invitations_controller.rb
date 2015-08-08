class InvitationsController < ApplicationController
  def index
    @invitations = current_user.invitations
  end

  def accept

  end

  def reject
    invitation = Invitation.find(params[:id])
    invitation.reject
    redirect_to invitations_url, status: 303
  end
end
