class EventsController < ApplicationController
  def index
    @events = Event.where(owner: current_user)
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to events_url, status: 303
  end

  def new
    @event = Event.new
  end

  def create

  end
end
