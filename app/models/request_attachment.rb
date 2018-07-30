class RequestAttachment < ApplicationRecord
	mount_uploader :file, FileUploader
	belongs_to :request, optional: true
end
