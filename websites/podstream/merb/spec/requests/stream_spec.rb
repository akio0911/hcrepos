require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/stream" do
  before(:each) do
    @response = request("/stream")
  end
end