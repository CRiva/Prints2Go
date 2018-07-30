module RequestsHelper
	require 'json'

	#include CostHelper

	def sortable(column, title = nil)
		title ||= column.titleize
		#if sort_direction == "asc"
		#	css_class = column == sort_column ? "glyphicon-chevron-up" : nil
		#else
		#	css_class = column == sort_column ? "glyphicon-chevron-down" : nil
		#end
		#css_class = column == sort_column ? "current #{sort_direction}" : nil
		direction = column == sort_column && sort_direction == "desc" ? "asc" : "desc"
		link_to title, {:sort => column, :direction => direction, :filter => params[:filter]}#, {:class => "glyphicon #{css_class}"}
	end 

	def requestsToGrabIndex
		if params[:filter] == 'completed'
			if admin 
				@requests = Request.where(:status => params[:filter], :billed => true).order(sort_column + " " + sort_direction).paginate(:page => params[:page],:per_page => 10) rescue nil
			else 
				@requests = Request.where(:requester => session[:cas_user], :status => params[:filter], :billed => true).order(sort_column + " " + sort_direction).paginate(:page => params[:page],:per_page => 10) rescue nil
			end
		elsif params[:filter] == 'new'
			if admin 
				@requests = Request.where(:status => params[:filter]).order(sort_column + " " + sort_direction).paginate(:page => params[:page],:per_page => 10) rescue nil
			else 
				@requests = Request.where(:requester => session[:cas_user], :status => params[:filter]).order(sort_column + " " + sort_direction).paginate(:page => params[:page],:per_page => 10) rescue nil
			end
		elsif params[:filter] == 'unbilled'
			if admin
				@requests = Request.where(:status => 'completed', :billed => false ).order(sort_column + " " + sort_direction).paginate(:page => params[:page],:per_page => 10) rescue nil
			else 
				@requests = Request.where(:requester => session[:cas_user], :status => 'completed', :billed => false).order(sort_column + " " + sort_direction).paginate(:page => params[:page],:per_page => 10) rescue nil
			end
		else
			if admin 
				@requests = Request.order(sort_column + " " + sort_direction).paginate(:page => params[:page],:per_page => 10) rescue nil
			else
				@requests = Request.where(requester: session[:cas_user]).order(sort_column + " " + sort_direction).paginate(:page=> params[:page],:per_page => 10) rescue nil
			end
		end
	end

	def totalCost(request)
		sum = 0.0
	end

	def getOptions(field)
		options = []
		Cost.where(:category => field).order(:per_page, :per_job).each do |cost|
			options.exclude?(cost.option) ? options.push(cost.option) : options
		end
		Cost.all.each do |cost|
			cost.cost_dependencies.where(:dependency_category => field).each do |cd|
				options.exclude?(cd.dependency_option) ? options.push(cd.dependency_option) : options
			end
		end
		return options
	end

 	def i_matter?(field, value)
 		if (["id", "jobtitle", "created_at", "updated_at", "requester",
 			"status", "pickup_date", "costcenter", "costcenter_number",
 			"estimate", "otherestimate", "billed", "stock", "cut", "pad",
 			"cost", "special_info", "finish", "completion"].exclude? field) and value != 0
 			return true
 		else
 			return false
 		end
 	end

 	def dependencies_applied(request, field, value)
 		cost = Cost.where(:option => [field,value])
 		values = request.attributes.values
 		dependencies = []
 		cost.each do |c| 
 			c.cost_dependencies.each do |cd|
				if values.include? cd.dependency_option
					dependencies.push(cd.dependency_option)
				end
 			end
 		end
 		return dependencies
 	end

 	def get_cost_per_page(field, value, dependencies)
 		price = 0.00
 		fieldHuman = field.dup()
 		fieldHuman = fieldHuman.humanize.titleize
 		if dependencies.any?	
 			maxD = 0.00
	 		costs = Cost.where(:option => [fieldHuman,value])
	 		costs.first.cost_dependencies.each do |cd|
	 			if cd.per_page > maxD
	 				maxD = cd.per_page
	 			end
	 		end
	 		price = maxD
	 	else
	 		costs = Cost.where(:option => [fieldHuman,value])
	 		if costs.any?
	 			price = costs.first.per_page
	 		elsif field == "originals"
	 			return "x#{value}"
	 		end
	 	end
	 	return price
 	end


 	def get_cost_per_job(field, value, dependencies)
 		price = 0.0
 		fieldHuman = field.dup()
 		fieldHuman = fieldHuman.humanize.titleize
 		if dependencies.any?
 			maxD = 0.00
	 		costs = Cost.where(:option => [fieldHuman,value])
	 		costs.first.cost_dependencies.each do |cd|
	 			if cd.per_job > maxD
	 				maxD = cd.per_job
	 			end
	 		end
	 		price = maxD
	 	else
	 		costs = Cost.where(:option => [fieldHuman,value])
	 		if costs.any?
	 			price = costs.first.per_job
	 		elsif field == "copies"
	 			return "x#{value}"
	 		end
	 	end
	 	return price
 	end

 	def setVariables
 		@sumpage = 0.00
		@sumjob = 0.00
		@multpage = 0
		@multjob = 0
	end
 	

	def gatherinfo(field, value)
		@deps = dependencies_applied(@request, field, value)
		@perpage = get_cost_per_page(field, value, @deps)
		@perjob = get_cost_per_job(field, value, @deps)
		@multpage = @perpage.is_a?(String) ? (value.to_i) : @multpage
		@multjob = @perjob.is_a?(String) ? (value.to_i) : @multjob
		@sumpage += @perpage.is_a?(Numeric) ? @perpage : 0
		@sumjob += @perjob.is_a?(Numeric) ? @perjob : 0
	end

end









