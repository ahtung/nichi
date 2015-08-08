class EventsController < ApplicationController
  def index
    @events = current_user.events
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy
    redirect_to events_path
  end
end
