require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Status, "index action" do
  before(:each) do
    dispatch_to(Status, :index)
  end
end