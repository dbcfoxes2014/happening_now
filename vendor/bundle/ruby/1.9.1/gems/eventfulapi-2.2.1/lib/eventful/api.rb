# A library for working with the Eventful API. Simple programmatic access to
# Eventful's database of events, venues, performers and speakers, groups,
# calendars, and users.
#
# See http://api.eventful.com for more information about the Eventful API and
# the available API methods.
#
# == Example Usage
#
#  require 'rubygems'
#  require 'eventful/api'
#
#  begin
#
#    # Start an API session with a username and password
#    eventful = Eventful::API.new 'application_key',
#                                 :user => 'username',
#                                 :password => 'password'
#
#    # Lookup an event by its unique id
#    event = eventful.call 'events/get',
#                          :id => 'E0-001-001042544-7'
#
#    puts "Event Title: #{event['title']}"
#
#    # Get information about that event's venue
#    venue = eventful.call 'venues/get',
#                          :id => event['venue_id']
#
#    puts "Venue: #{venue['name']}"
#
#  rescue Eventful::APIError => e
#    puts "There was a problem with the API call: #{e}"
#  end
#
#
# == Another Example
#
#  require 'rubygems'
#  require 'eventful/api'
#
#  # First, create our Eventful::API object
#  eventful = Eventful::API.new 'application_key'
#
#  loop do
#    # Ask the user what and where to search
#    puts "Search where? (Ex: San Diego)"
#    print "? "
#    location = gets.chomp
#    puts "Search for what (Ex: music)"
#    print "? "
#    query = gets.chomp
#
#    # This is the cool part!
#    results = eventful.call 'events/search',
#                            :keywords => query,
#                            :location => location,
#                            :page_size => 5
#
#    # If we couldn't find anything, ask the user again
#    if results['events'].nil? then
#      puts
#      puts "Hmm. I couldn't find anything. Sorry."
#      puts
#      next
#    end
#
#    # Output the results
#    results['events']['event'].each do |event|
#      puts
#      puts "http://eventful.com/events/" + event['id']
#      puts event['title']
#      puts "  at " + event['venue_name']
#      puts "  on " + Time.parse(event['start_time']).strftime("%a, %b %d, %I:%M %p") if event['start_time']
#    end
#    puts
#  end
#
#
# == API Key
#
# Use of the Eventful API requires an application key
# (see http://api.eventful.com/keys for more information).
#
# == Change Notes
#
# === Eventful API
# ==== Version 2.2.1
#
# - Updated Paul Knight's contact email in the docs
#   (please reach him at pknight@eventful.com)
#
# ==== Version 2.2.0
#
# - The authentication bug has been fixed, so I'm rolling back the workaround.
# - Documented the parameters for specifying alternative API servers when calling
#   Eventful.new
# - The names of these keys have been changed to be a bit friendlier. The old
#   keys will still work fine.
# - Hash keys to methods can now be Symbols, in addition to strings
# - A fun new example, just because
#
# ==== Version 2.1.1
#
# - Includes a workaround fix for an authentication bug. This fix may be rolled
#   back should the workaround become unecessary in the future.
#
# ==== Version 2.1
#
# - As EVDB Inc. has been renamed Eventful Inc., the EVDB module has been
#   renamed Eventful, and the gem is now named eventfulapi. Support for the
#   evdbapi gem is being discontinued; please use the eventfulapi gem from now on.
# - Much better at throwing an error when a network or server problem happens,
#   rather than failing silently and mysteriously
# - Documentation improvements
#
# === EVDB API
#
# ==== Version 2.0.1
#
# - Fixed a minor documentation error
#
# ==== Version 2.0
#
# Version 2.0 of this library includes some significant changes which may not
# be backwards compatible. Specifically:
#
# - Anonymous logins are now allowed
# - Fixes a potential image uploading API error
#
# Most importantly, the library now uses YAML as its data exchange format instead of
# XML, and the objects returned from a call can be used like hashes instead of
# REXML objects.
#
# == Information
#
# Status::             Stable
# Version::            2.2.1
# Date::               2007-03-24
# Current Author::     Paul Knight (mailto:pknight@eventful.com)
# Previous Authors::   Joe Auricchio
# Copyright::          Copyright (C) 2005-2007 Eventful Inc.
# License::            This code is distributed under the same terms as Ruby 
#                      itself (see http://www.ruby-lang.org/en/LICENSE.txt)





# mime/types is available as a gem, but that's out of our way if it happens to
# be in our load path somewhere
begin
  require 'mime/types'
rescue LoadError
  require 'rubygems'
  require 'mime/types'
end

# The rest of these are part of the standard distribution
require 'yaml'
require 'cgi'
require 'net/http'
require 'base64'
require 'digest/md5'





module Eventful



  # Version descriptor of this library
  VERSION = '2.2.1'

  # Default API server to connect to
  DEFAULT_SERVER = 'api.eventful.com' #:nodoc:
  # Default server port
  DEFAULT_PORT = 80 #:nodoc:
  # Default server path
  DEFAULT_ROOT = '/yaml/' #:nodoc:

  # Our POST data boundary
  BOUNDARY = '1E666D29B5E749F6A145BE8A576049E6' #:nodoc:
  BOUNDARY_MARKER = "--#{BOUNDARY}" #:nodoc:
  BOUNDARY_END_MARKER = "--#{BOUNDARY}--" #:nodoc:



  # Parent Error used for all Eventful exceptions
  class Error < StandardError ; end

  # An error that may also include the YAML response from the server
  class APIError < Error
    attr_reader :response

    # Creates a new exception.
    def initialize(response)
      super
      @response = response
    end

    # The error string returned by the API call.
    def to_s
      "#{@response['string']}: #{@response['description']}"
    end
  end



  # A class for working with the Eventful API.
  class API



    # Create an object for working with the Eventful API. Working with the API
    # requires an application key, which can be obtained at http://api.eventful.com/keys/
    #
    # Options may be:
    #
    # <tt>:user</tt>:: Authenticate as this user, required for some API methods. A password must also be specified.
    # <tt>:password</tt>:: Password for user authentication.
    #
    # If both <tt>user</tt> and <tt>password</tt> are specified, then digest
    # authenticatino will be used. Otherise, basic authentication will be used.
    # Please note that basic authentication sends passwords in the clear.
    # For more information, please see http://api.eventful.com/docs/auth
    #
    # ==== Testing Against Another Server
    #
    # For testing, you may use the following options for specifying a
    # different API server:
    #
    # <tt>:server</tt>:: Hostname of the API server, default <tt>api.eventful.com</tt>
    # <tt>:root</tt>:: Path to the root of all method calls, default <tt>/yaml/</tt>
    # <tt>:port</tt>:: Server port, default <tt>80</tt>
    #
    # If the server is behind HTTP authentication, you can use:
    #
    # <tt>:http_user</tt>:: Username for HTTP authentication
    # <tt>:http_password</tt>:: Password for HTTP authenciation
    #
    # Please note that none of these five options are needed for using the Eventful API.
    #
    # ==== Example
    #
    #  eventful = Eventful::API.new 'app_key',
    #                               :user => 'username',
    #                               :password => 'password'
    #
    def initialize(app_key, options = {})
      # Grab our arguments

      @server = find_option [:server, :api_server], options, DEFAULT_SERVER
      @root = find_option [:root, :api_root], options, DEFAULT_ROOT
      @port = find_option [:port, :api_port], options, DEFAULT_PORT

      @http_user = find_option [:http_user, :auth_user], options
      @http_password = find_option [:http_password, :auth_password], options

      user = find_option [:user], options
      password = find_option [:password], options

      # User authentication
      if user and password
        # Get a nonce; we expect an error response here, so rescue the exception and continue
        begin
          response = call 'users/login',
                          :app_key => app_key
        rescue APIError => error
          raise unless error.response['nonce']
          nonce = error.response['nonce']
        end

        # Login with a hash of the nonce and our password
        login_hash = Digest::MD5.hexdigest "#{nonce}:#{Digest::MD5.hexdigest(password)}"
        response = call 'users/login',
                        :app_key => app_key,
                        :user => user,
                        :nonce => nonce,
                        :response => login_hash

        # Store authentication information and use it for all future calls
        @authentication = { :app_key => app_key,
                            :user => user,
                            :user_key => response['user_key'] }
      else
        @authentication = { :app_key => app_key }
      end
    end



    # Search through a method argument Hash for specified named parameters
    def find_option(names, arguments, default = nil) #:nodoc:
      result = default
      names.each do |name|
        result = arguments[name] || arguments[name.to_s] || result
      end
      return result
    end




    # Prepares the body of the POST request
    def prepare_post(params) #:nodoc:
      content = ""
      params.each do |key, value|
        content += BOUNDARY_MARKER + "\r\n"
        if key.to_s =~ /_file$/
          content += "Content-Disposition: file; name=\"#{CGI::escape(key.to_s)}\"; filename=\"#{value}\"\r\b"
          content += "Content-Type: #{MIME::Types.type_for(value.to_s)}\r\n"
          content += "Content-Transfer-Encoding: binary\r\n\r\n"
          content += open(value) { |f| f.read } + "\r\n"
        else
          content += "Content-Disposition: form-data; name=\"#{CGI::escape(key.to_s)}\";\r\n\r\n#{value}\r\n"
        end
      end
      content += BOUNDARY_END_MARKER
      return content
    end



    # Calls an API method with the given parameters, and returns the reply as
    # a hash. Please see the Eventful API documentation (http://api.eventful.com/docs)
    # for information about methods and their parameters.
    #
    # ==== Example
    #
    #  event = eventful.call 'events/get',
    #                        :id => 'E0-001-001042544-7'
    #
    def call(method, params = {})
      # Use available auth tokens
      params.merge! @authentication if @authentication

      response = Net::HTTP.start(@server, @port) do |connection|
        if @http_user and @http_password then
          connection.post(
            "#{@root}#{method}",
            prepare_post(params),
            "Content-type" => "multipart/form-data; boundary=#{BOUNDARY} ",
            "Authorization" => Base64.encode64("#{@http_user}:#{@http_password}"))
        else
          connection.post(
            "#{@root}#{method}",
            prepare_post(params),
            "Content-type" => "multipart/form-data; boundary=#{BOUNDARY} ")
        end
      end

      # Raise an exception if we didn't get a 2xx response code
      response.value

      yaml = YAML::load response.body

      # Raise an error if we got an API error
      raise APIError.new(yaml['error']) if yaml['error']

      return yaml
    end



  end # class API
end # module Eventful
