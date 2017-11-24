class EmailFormatValidator < ActiveModel::EachValidator
	
  def validate_each(object, attribute, value)
  	# checks current market for email type allowed
	unless value =~ /^([^@\s]+)@#{$current_market.email_address_type}/i
      object.errors.add(attribute, :email_format, options)
	end
  end

end