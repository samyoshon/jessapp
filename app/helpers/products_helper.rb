module ProductsHelper
	def categories_for_select
	  Category.all.collect { |m| [m.category_name, m.id] }
	end
end
