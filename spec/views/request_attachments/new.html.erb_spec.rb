require 'rails_helper'

RSpec.describe "request_attachments/new", type: :view do
  before(:each) do
    assign(:request_attachment, RequestAttachment.new(
      :request_id => 1,
      :file => "MyString"
    ))
  end

  it "renders new request_attachment form" do
    render

    assert_select "form[action=?][method=?]", request_attachments_path, "post" do

      assert_select "input#request_attachment_request_id[name=?]", "request_attachment[request_id]"

      assert_select "input#request_attachment_file[name=?]", "request_attachment[file]"
    end
  end
end
