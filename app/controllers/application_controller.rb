class ApplicationController < ActionController::Base
  	protect_from_forgery with: :exception
  	before_action CASClient::Frameworks::Rails::Filter

  	def admin
  		if Request.admins.include? session[:cas_user]
  			return true
  		else
  			return false
  		end
  	end
  	helper_method :admin

end
