require 'rails_helper'

RSpec.describe "request_attachments/index", type: :view do
  before(:each) do
    assign(:request_attachments, [
      RequestAttachment.create!(
        :request_id => 2,
        :file => "File"
      ),
      RequestAttachment.create!(
        :request_id => 2,
        :file => "File"
      )
    ])
  end

  it "renders a list of request_attachments" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "File".to_s, :count => 2
  end
end
