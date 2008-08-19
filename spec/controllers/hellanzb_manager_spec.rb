require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe HellanzbManager, "index action" do
  before(:each) do
    dispatch_to(HellanzbManager, :index)
  end
end