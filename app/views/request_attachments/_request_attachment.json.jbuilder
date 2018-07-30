json.extract! request_attachment, :id, :request_id, :file, :created_at, :updated_at
json.url request_attachment_url(request_attachment, format: :json)