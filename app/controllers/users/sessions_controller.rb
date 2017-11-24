class Users::SessionsController < Devise::SessionsController
	def create
	    self.resource = warden.authenticate!(auth_options)
	    # set_flash_message!(:notice, :signed_in) # deleted to show alert messages
	    sign_in(resource_name, resource)
	    yield resource if block_given?
	    respond_with resource, location: after_sign_in_path_for(resource)
	end


	def after_sign_in_path_for(resource)
		if current_user.admin == true
			flash[:alert] = "Signed in successfully."
			stored_location_for(resource) || root_path
		elsif current_user.market_id != @market.id
			# current_user.deactivate_user(@user)
		    sign_out(@user)
		    flash[:alert] = "Email is not a valid email address."
			new_user_session_path
		else
			flash[:alert] = "Signed in successfully."
			stored_location_for(resource) || root_path
		end
	end
end
