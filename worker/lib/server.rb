module HGT

	class Server

	  FREQUENCY = 5
	  WINDOW    = 50 * 60 # minutes to go back in time

	  attr_accessor :database, :logger

	  class << self
	    
	    ##
	    # Singleton
	    ##
	    def instance
	      @instance
	    end

	    ##
	    #
	    ##
	    def create(database)
	      @instance = HGT::Server.new(database)
	      @instance
	    end

	  end

	  ##
	  #
	  ##
	  def initialize(database)
	    @database = database
	    @logger =  HGT::Log::Console.new
	    @last   = nil
	  end

	  ##
	  # called after EM loop is running but before start
	  ##
	  def setup
	    # trap signals
	    trap("INT")   { logger.log('SERVER','Shutting down. One moment please.'); EM.stop; }
	    trap("TERM")  { logger.log('SERVER','Shutting down. One moment please.'); EM.stop; }
	  end

	  ##
	  #
	  ##
	  def start(&block)
	  	# This is our poll timer
	    EM.add_periodic_timer(FREQUENCY) { poll }

	    # run once now
	    poll
	  end

	  ##
	  # called after the EM loop has been torn down
	  ##
	  def end
	    logger.log("SERVER", "Goodbye")
	    File.delete(@pid) if !@pid.nil? && File.file?(@pid)
	  end

	  ##
	  #
	  ##
	  def poll

	  	# set time stamp if we do not have 
	  	if @last.nil?
	  		@last = Time.now - WINDOW
	  	end

	  	# perform query
	  	uri = "#{database}/hgt/_design/hgt/_view/timestampuser?startkey=\"#{@last.utc.strftime('%Y-%m-%dT%H:%M:%S')}\""
	  	puts "URI: #{uri}"

        http = EventMachine::HttpRequest.new(uri).get #:query => {'keyname' => 'value'}

        http.errback { p 'Uh oh'; EM.stop }
        http.callback {
          #p http.response_header.status
          #p http.response_header
          hash = Yajl::Parser.parse http.response

          hash['rows'].each  {|user| fetch_user_friends user["value"] } 
         # EventMachine.stop
        }



        @last = Time.now
	  	
	  end

	  ##
	  #
	  ##
	  def fetch_user_friends(user)

	  	return if user['token'].nil? || user['token'] == ''
	 
	  	u = FbGraph::User.fetch(user['id'], access_token: user['token'] )

	  	user.delete('timestamp')

		unless u.nil?
			 {
   				
   				:name => "facebook_name",
   				:first_name => "facebook_first_name",
   				:middle_name => "facebook_middle_name",
   				:last_name => "facebook_last_name",
   				:user_name => "facebook_user_name",
   				:gender => "gender"
			  }.each do |key, value|
			  	v = u.respond_to?(key) ? u.send(key) : nil 
			  	user[value] = v unless v.nil?
			  end

			user['facebook_friends'] = []
			u.friends.each  { |f|  user['facebook_friends'] <<  f.raw_attributes['id'] }
		end

	  	# post back to the user url to update
	  	json = Yajl::Encoder.encode(user)
	  	uri = "#{database}/hgt/_design/hgt/_update/user/#{user['id']}?nostamp=yes"


	  	puts "---------------------"
	  	puts "POST #{uri}"

	  	http = EventMachine::HttpRequest.new(uri).post body: json, :head => {"Content-Type" => "application/json"}

	  	http.callback {
	  		puts http.inspect
	  	}

	  	nil
	  end


	end

end








