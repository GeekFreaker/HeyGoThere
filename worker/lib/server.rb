module HGT

	class Server

	  FREQUENCY = 5
	  WINDOW    = 10 * 60 # minutes to go back in time

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

	  	# update time
	  	@last = Time.now


	  	# 
	  	Fiber.new {
        }.resume  

	  	logger.log("SERVER", "Poll")
	  end


#curl -g -X GET "$SERVER/hgt/_design/hgt/_view/users


	end

end








