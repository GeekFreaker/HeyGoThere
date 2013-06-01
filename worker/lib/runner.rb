module HGT
	class Runner
      DEFAULT_DATABASE = "http://localhost:5984"

      ##
      #
      ##
      def initialize(argv)
        set_default_options
        parser = create_parser
        parser.parse(argv)


        @deamonize      = @options[:daemonize]
        @verbose        = @options[:verbose]
        @database 		= @options[:database]

        @options[:log_file] = default_log_file(@options[:id]) unless @options.include?(:log_file)
        @options[:pid_file] = default_pid_file(@options[:id]) unless @options.include?(:pid_file)


        @pid_file       = @options[:pid_file]
        @log_file       = @options[:log_file]

      end

      ##
      #
      ##
      def run
        # load the config file
        config = {}
        config[:pid] = @pid_file    
        

        if @deamonize
          puts "=== Hey Go There ==="
          puts "[SERVER] => Starting daemonized process"
          Process.fork do 

            # setsid
            Process.setsid
            exit if fork

            # store pid
            store_pid(Process.pid)

            # redirect stdout
            STDIN.reopen('/dev/null')
            STDOUT.reopen(@log_file, 'a')
            STDERR.reopen(STDOUT)         

            server = HGT::Server.create(@options[:database])
            start_processing(server)
          end
        else
          puts "=== WebQ ==="
          puts "[SERVER] => Starting interactive process"

          store_pid($$)
          server = HGT::Server.create(@options[:database])
          start_processing(server)
        end

      end


      ##
      # run the server
      ##
      def start_processing(server)
        EM.epoll
        EM.run {
          server.setup()
          server.start()
        }
        server.end()
      end


      private

      ##
      # Construct the option hash and set the defaults
      ##
      def set_default_options
        @options = {
          database:       DEFAULT_DATABASE,
          daemonize:      false,
          verbose:        false,
        }
      end

      ##
      # create the option parser
      ##
      def create_parser
        OptionParser.new do |opts|

          opts.banner = "Usage: ./hgt start <options>"

          opts.separator ""
          opts.separator "Server options:"
          opts.on('-d', '--database DATABASE', "Use database (default: #{@options[:database]})") { |v| @options[:database] = v }

          opts.separator ""
          opts.separator "Daemon options:"
          opts.on('-u', '--user USER', "Run as a specific user") { |v| @options[:user] = v }
          opts.on('-d', '--daemonize', "Run daemonize in the background (default: #{@options[:daemonize]})") { |v| @options[:daemonize] = v }
          opts.on('-l', '--log FILE', "Log to file (default: #{default_log_file('<id>')} )") { |v| @options[:log_file] = v }
          opts.on('-P', '--pid FILE', "Run daemonize in the background (#{default_pid_file('<id>')})") { |v| @options[:pid_file] = v }

          opts.separator ""
          opts.separator "Common options:"
          opts.on('-v', '--verbose', "Enable verbose logging (default: #{@options[:verbose]})") { |v| @options[:verbose] = v }
          opts.on('-h', '--help', 'Display help message') { show_options(opts) }

        end     
      end


      ##
      #
      ##
      def default_pid_file(id)
        base = File.expand_path(File.join(File.dirname(__FILE__),'..','pid'))
        File.join(base,"hgt.pid")
      end

      ##
      #
      ##
      def default_log_file(id)
        base = File.expand_path(File.join(File.dirname(__FILE__),'..','log'))
        File.join(base,"hgt.log")
      end

      ##
      # Show the options
      ##
      def show_options(opts)
        puts opts
        at_exit { exit! }
        exit
      end

      ##
      #
      ##
      def store_pid(pid)
         File.open(@pid_file, 'w') { |f| f.write(pid) }      
      end

    end
end







