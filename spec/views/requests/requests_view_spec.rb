require 'rails_helper'

RSpec.describe "requests/index", :type => :view do
  it "renders table of user's requests, unless admin, then all" do
    render
    expect(rendered).to  have_text("ID")
    expect(rendered).to  have_text("Date")
    expect(rendered).to  have_text("Jobtitle")
	expect(rendered).to  have_text("Copies")
	expect(rendered).to  have_text("File")
	expect(rendered).to  have_text("Pickup")
	expect(rendered).to  have_text("Status")
	expect(rendered).to  have_text("Action")
  end
end