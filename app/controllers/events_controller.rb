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
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, user_ids: [])
  end
end
