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
    client = Google::APIClient.new
    client.authorization.access_token = current_user.refresh_token
    service = client.discovered_api('calendar', 'v3')
    @calendar = client.execute(:api_method => service.calendars.insert,
                        :body => JSON.dump({ 'summary' => 'nichi Calendar' }),
                        :headers => {'Content-Type' => 'application/json'})
    calendar_id = ActiveSupport::JSON.decode(@calendar.response.body) if @calendar.status == 200
    @calendar_id = calendar_id['id']
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
