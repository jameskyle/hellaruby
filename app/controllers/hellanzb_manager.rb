class HellanzbManager < Application
   def resume
    @hella.continue   
    redirect "/status"
  end
  def pause
    @hella.pause
    redirect "/status"
  end
  def server_info
    partial "server_info"
  end
end
