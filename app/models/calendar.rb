class Calendar < ActiveRecord::Base
  belongs_to :user

  attr_accessor :client

  def self.gcalendar(attributes={})
    @client ||= Google::APIClient.new
    @client.authorization.access_token = attributes[:user].refresh_token
    @service = @client.discovered_api('calendar', 'v3')
  end

  def self.new_calendar
    @calendar = @client.execute(
      api_method: @service.calendars.insert,
      body: JSON.dump({ 'summary' => 'nichi Calendar' }),
      headers: { 'Content-Type' => 'application/json'}
    )
    puts @calendar.inspect
    puts 'helo'
    if @calendar.status == 200
      return google_calendar_id = ActiveSupport::JSON.decode(@calendar.response.body)['id']
    else
      return false
    end
  end
end
