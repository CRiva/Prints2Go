require 'rails_helper'

RSpec.describe "routing to root", :type => :routing do

	describe "routes" do
	  it "routes '/' to the index action of the request controller" do
	    expect(get: "/").to route_to(controller: "requests", action: "index")
	  end
	end
end