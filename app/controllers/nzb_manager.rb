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
    # To Do: output html for queue list
    @hella.list.each do |item|
     puts  %Q! link_to "[-]", "/nzb_manager/queue_down/#{item['id']}"
      link_to "[+]", "/nzb_manager/queue_up/#{item['id']}" 
      link_to "[last]", "/nzb_manager/queue_last/#{item['id']}"
      link_to "[first]", "/nzb_manager/queue_first/#{item['id']}"
      link_to "[download now]", "/nzb_manager/queue_force/#{item['id']}"
   item['nzbName'].capitalize
    link_to "[delete]", "/nzb_manager/dequeue/#{item['id']}" <br />!
   end 
  end
end
