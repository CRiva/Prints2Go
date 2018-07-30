require 'rails_helper'

RSpec.describe "request_attachments/show", type: :view do
  before(:each) do
    @request_attachment = assign(:request_attachment, RequestAttachment.create!(
      :request_id => 2,
      :file => "File"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/File/)
  end
end
