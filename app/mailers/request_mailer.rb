class RequestMailer < ApplicationMailer

	default :from => '<REDACTED>'

	def send_confirmation_email_to_user(request, user)
		@request = request
		@user = user
		mail( :to => "#{@request.requester}@<REDACTED>",
			  :subject => 'Your Prints2Go Request')

	end

	#g8p4q1a2t0o2y0g8@westmont-it.slack.com   <- to send to pritns2go slack channel

	def send_request_email_to_admin(request, username)
		@request = request
		@username = username
		mail( :to => "<REDACTED>",
			  :subject => 'New Prints2Go Request')
	end
end
