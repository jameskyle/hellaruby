class Hellanzb
  require 'xmlrpc/client'
  attr_reader :config_file, :prefix_dir, :queue, :dest_dir

  def initialize 
    begin
      @server ||= XMLRPC::Client.new2(HELLA_URL)
      # Create a method accessor for each of the server methods
      @server.call('system.listMethods').each do |m|
        if m.eql?("down") or m.eql?("up") or m.eql?("dequeue") or 
           m.eql?("last") or m.eql?("next") or m.eql?("force") or
           m.eql?("enqueue") or m.eql?("enqueueurl") or m.eql?("enqueuenewzbin")

          self.class.send(:define_method, m) {|id| @server.call(m,id)} 
        else
          self.class.send(:define_method, m) {@server.call(m)}
        end
      end
      # the hellanzb daemon has many status fields. Above we created the status method
      # that returns all the values in a hash. Below we create specific accessors for each
      # status value.
      # List of methods created here:
      #  queued_mb
      #  percent_complete
      #  time
      #  total_dl_nzbs
      #  is_paused
      #  maxrate
      #  rate
      #  currently_downloading
      #  currently_processing
      #  total_dl_files
      #  version
      #  eta
      #  config_file
      #  hostname
      #  queued
      #  uptime
      #  log_entries
      #  total_dl_segments
      #  total_dl_mb
      
      status.each do |s|
        self.class.send(:define_method, s[0]) {@server.call("status")[s[0]]}
      end
    rescue Errno::ECONNREFUSED
      system(HELLA_BIN+" -c #{Merb.root}/config/hellanzb.conf -D")
      retry
    end

    @config_file ||= self.status['config_file']
    get_settings
  end
 
  private
  def get_settings
    File.open(self.config_file, 'r').readlines.each do |line|
      if m = line.match(/^Hellanzb\.PREFIX_DIR\s*=\s*'(.*)'.*$/) then
        @prefix_dir = m[1]
      elsif m = line.match(/^Hellanzb\.QUEUE_DIR\s*=\s*(.*)$/)
        queue = m[1].gsub!(/Hellanzb\.PREFIX_DIR\s*\+\s*/,"").gsub!(/'/,"")
        
        if m[1].match(/Hellanzb\.PREFIX_DIR/) then
          @queue = self.prefix_dir + "/" + queue
        else
          @queue = queue
        end

      elsif m = line.match(/^Hellanzb\.DEST_DIR\s*=\s*(.*)$/) then
        dest_dir = m[1].gsub(/Hellanzb\.PREFIX_DIR\s*\+\s*/,"").gsub(/'/,"")
        if m[1].match(/Hellanzb\.PREFIX_DIR/) then
          @dest_dir = self.prefix_dir + "/" + dest_dir
        else
          @dest_dir = dest_dir
        end

      end
    end
  end
end
