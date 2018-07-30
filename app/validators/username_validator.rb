class UsernameValidator < ActiveModel::Validator
	require 'net/http'

	def validate(record)

		uri = URI.parse("<REDACTED>")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.set_debug_output($stdout)

		request = Net::HTTP::Head.new("/users/#{record[:requester]}")
		request["Authorization"] = "<REDACTED>"
		response = http.request(request)
		if response.code.to_i != 200
			record.errors.add(:requester, "must be a valid westmont userid.")
		end
	end
end