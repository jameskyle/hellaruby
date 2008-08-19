require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe NzbManager, "index action" do
  before(:each) do
    dispatch_to(NzbManager, :index)
  end
end