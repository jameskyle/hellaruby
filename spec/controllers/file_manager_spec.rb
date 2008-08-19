require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe FileManager, "index action" do
  before(:each) do
    dispatch_to(FileManager, :index)
  end
end