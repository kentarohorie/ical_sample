require 'sinatra'
require 'icalendar'

get '/add_event' do
  calendar = Icalendar::Calendar.new
  calendar.timezone do |t|
    t.tzid = 'Asia/Tokyo'
    t.standard do |s|
      s.tzoffsetfrom = '+0900'
      s.tzoffsetto   = '+0900'
      s.tzname       = 'JST'
    end
  end

  calendar.event do |e|
    e.dtstart = Icalendar::Values::Date.new(Date.parse(params[:date]))
    e.summary = params[:event_name]
    e.description = params[:description]
  end

  calendar.publish

  content_type 'text/calendar'
  calendar.to_ical
end
