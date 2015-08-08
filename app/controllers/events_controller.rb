class EventsController < ApplicationController
  def index
    @events = current_user.events
  end

  def destroy
  end
end
