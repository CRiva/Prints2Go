require 'rails_helper'

RSpec.describe "request_attachments/edit", type: :view do
  before(:each) do
    @request_attachment = assign(:request_attachment, RequestAttachment.create!(
      :request_id => 1,
      :file => "MyString"
    ))
  end

  it "renders the edit request_attachment form" do
    render

    assert_select "form[action=?][method=?]", request_attachment_path(@request_attachment), "post" do

      assert_select "input#request_attachment_request_id[name=?]", "request_attachment[request_id]"

      assert_select "input#request_attachment_file[name=?]", "request_attachment[file]"
    end
  end
end
