class FileManager < Application
  def cancel_download
    @hella.cancel
    redirect "/status/"
  end
  def download_progress
    result = @hella.percent_complete.to_s << "|" << 
      @hella.rate.to_s 
    if !@hella.currently_downloading.nil? then
      result << "|" << @hella.currently_downloading['nzbName'] 
    else
      result << "|" << "none"
    end
    result
  end
  def processing
    if !@hella.currently_processing.nil? then
      @hella.currently_processing['nzbName']
    else
      "None"
    end
  end
  def list
    @dirs = Hash.new
    dirs = Dir.entries(@hella.dest_dir).delete_if {|x| x.match(/^\./)}
    dirs.each do |dir|
      if File.directory?((@hella.dest_dir + "/" + dir)) then
        files = Dir.entries((@hella.dest_dir + "/" + dir)).delete_if {|d| d.match(/^\./)} 
        @dirs[dir] = files
      end
    end

    Merb.logger.info("Found Files: #{@dirs.inspect}")
    render
  end
  
  def delete
    FileUtils.rm_rf(@hella.dest_dir + "/" + params[:name])
    redirect "/file_manager/list"
  end
  def download_file
    send_file(@hella.dest_dir+"/"+params[:name])
  end
end
