module CostsHelper

	include RequestsHelper

	def getAllCategories
		categories = ['Please Select']
		Cost.all.each do |cost|
			if categories.exclude? cost.category
				categories.push(cost.category)
			end	
			cost.cost_dependencies.all.each do |cd|
				if categories.exclude? cd.dependency_category
					categories.push(cd.dependency_category)
				end
			end
		end
		categories.push("New Category")
		return categories
	end

	def getAppropriateOptions
		options = ['Select a Category'] 
		Cost.all.each do |cost|
			if options.exclude? cost.option
				options.push(cost.option)
			end
			cost.cost_dependencies.all.each do |cd|
				if options.exclude? cd.dependency_option
					options.push(cd.dependency_option)
				end
			end
		end
		options.push("New Option")
		return options
	end

	def self.focus_cost_id
		
	end

	def set_focus
		num = params[:num]
		self.focus_cost_id = num
	end

	def get_focus
		return self.focus_cost_id
	end


end
