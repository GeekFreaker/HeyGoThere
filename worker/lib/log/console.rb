  module HGT
    module Log
      class Console

        ##
        #
        ##
        def log(obj, msg)
          puts "[#{obj}] INFO => #{msg}"
        end

        ##
        #
        ##
        def warn(obj, msg)
          puts "[#{obj}] WARN => #{msg}"
        end


        ##
        #
        ##
        def debug(obj, msg)
          puts "[#{obj}] DEBUG => #{msg}"
        end


      end
    end
  end
