class EventsController < ApplicationController
  def index
    @events = Event.where(owner: current_user)
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    binding.pry
    redirect_to events_path
  end
end
