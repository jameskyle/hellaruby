module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  
    def secs_to_time(time)
      Time.at(time).gmtime.strftime('%R:%S')
    end
  end
end    
