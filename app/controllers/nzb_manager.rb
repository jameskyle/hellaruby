class NzbManager < Application
  def upload_nzb
    if !params[:file].empty? then
      FileUtils.mv params[:file][:tempfile].path, @hella.queue+"/#{params[:file][:filename]}"
    else
      flash[:notice] = "Choose a file first!"
    end
    redirect "/status"
  end

  def get_nzb_from_url
    @hella.enqueue(params[:nzb_url])
    redirect "/status"
  end

   def queue_down
    @hella.down(params[:id])
    redirect "/status"
  end
  def queue_up
    @hella.up(params['id'])
    redirect "/status"
  end
  def dequeue
    @hella.dequeue(params['id'])
    redirect "/status"
  end
  def queue_last
    @hella.last(params['id'])
    redirect "/status"
  end
  def queue_first
    @hella.next(params['id'])
    redirect "/status"
  end
  def queue_force
    @hella.force(params['id'])
    redirect "/status"
  end
  def clear_queue
    @hella.clear
    redirect "/status"
  end
  def queue_list
    partial "queue_list"
  end
end
