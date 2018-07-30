class CostDependenciesController < ApplicationController

  before_action only: [:new, :edit, :destroy, :show] do
    admin?
  end

  def admin?
    if !admin
      flash[:error] = "You are not allowed there"
      redirect_to action: 'index', controller: 'costs', :status => 303
    end
  end

	def new
		@cost = Cost.find(params[:cost_id])
		@cost_dependency = CostDependency.new
		respond_to do |format|
		    format.html # new.html.erb
		    format.json { render json: @cost_dependency }
	    end
	end

	def edit
  	@edit = true
  	@cost = Cost.find(params[:cost_id])
  	@cost_dependency = @cost.cost_dependencies.find(params[:id])
  end

	def index

	end

	def create
		@cost = Cost.find(params[:cost_id])
		@cost_dependency = @cost.cost_dependencies.new(cost_dependencies_params)
    @cost_dependency.dependency_category = @cost_dependency.dependency_category.strip
    @cost_dependency.dependency_option   = @cost_dependency.dependency_option.strip
		respond_to do |format|
        if @cost_dependency.save
          format.html { redirect_to controller: 'costs', action: 'index', status: 303, notice: [true, 'Cost Dependency was successfully created.'] }
          format.json { render json: @cost_dependency, status: :created, location: @cost }
        end
      end
	end

	def update
  	@cost = Cost.find(params[:cost_id])
  	@cost_dependency = @cost.cost_dependencies.find(params[:id])
    @cost_dependency.dependency_category = @cost_dependency.dependency_category.strip
    @cost_dependency.dependency_option   = @cost_dependency.dependency_option.strip
  	respond_to do |format|
    		if @cost_dependency.update_attributes(cost_dependencies_params)
      		format.html { redirect_to controller: 'costs', action: 'index', status: 303, notice: [true, 'Cost was successfully updated.'] }
      		format.json { head :no_content }
    		else
      		format.html { render action: "edit" }
      		format.json { render json: @cost.errors, status: :unprocessable_entity }
    		end
  	end
	end

  def destroy
    @cost = Cost.find(params[:cost_id])
    @cost_dependency = @cost.cost_dependencies.find(params[:id])
    @cost_dependency.destroy

    respond_to do |format|
      format.html { redirect_to controller: 'costs', action: 'index', status: 303, alert: [true, 'Cost Dependency has been deleted.'] }
      format.json { head :no_content }
    end
  end


	private
	def cost_dependencies_params
    	params.require(:cost_dependency).permit(:cost_id, :dependency_category, :dependency_option, :per_job, :per_page)
  	end

end

