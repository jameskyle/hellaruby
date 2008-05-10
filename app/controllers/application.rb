# all your other controllers should inherit from this one to share code.
class Application < Merb::Controller
  before :start
  def start
    @hella ||= Hellanzb.new
  end
end  
