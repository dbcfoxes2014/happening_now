require 'rubygems'
require 'eventful/api'

 # First, create our Eventful::API object
eventful = Eventful::API.new 'application_key'

loop do
 # Ask the user what and where to search
 puts "Search where? (Ex: San Diego)"
 print "? "
 location = gets.chomp
 puts "Search for what (Ex: music)"
 print "? "
 query = gets.chomp

 # This is the cool part!
 results = eventful.call 'events/search',
                         :keywords => query,
                         :location => location,
                         :page_size => 5

 # If we couldn't find anything, ask the user again
 if results['events'].nil? then
   puts
   puts "Hmm. I couldn't find anything. Sorry."
   puts
   next
 end

 # Output the results
 results['events']['event'].each do |event|
   puts
   puts "http://eventful.com/events/" + event['id']
   puts event['title']
   puts "  at " + event['venue_name']
   puts "  on " + Time.parse(event['start_time']).strftime("%a, %b %d, %I:%M %p") if event['start_time']
 end
 puts
end
