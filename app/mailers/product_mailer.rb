class ProductMailer < ApplicationMailer
	def view
		mail(to: "samuelyshon@gmail.com", subject: "People are viewing your product!")
	end
end
