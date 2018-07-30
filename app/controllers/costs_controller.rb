class CostsController < ApplicationController

  include CostsHelper

  before_action only: [:new, :edit, :destroy, :show] do
    admin?
  end

  def admin?
    if !admin
      flash[:error] = "You are not allowed to do that to costs."
      redirect_to action: 'index', :status => 303
    end
  end

  def populate_options
    category = params[:category]
    options = []
    Cost.all.each do |cost|
      if cost.category == category
        options.exclude? cost.option ? (options.push(cost.option)) : options
      end
      cost.cost_dependencies.all.each do |cd|
        if cd.dependency_category == category
          options.exclude? cd.dependency_option ? (options.push(cd.dependency_option)) : options
        end
      end
    end
    options = options.uniq
    respond_to do |format|
      format.json {
        render json: options
      }
    end
  end

  def get_appropiate_parameters(params)
    parms = [params[:color],
            params[:sides],
            params[:weight], 
            params[:binding], 
            params[:size],
            params[:folding], 
            params[:collate] == "true" ? ("Collate") : "Nilch",
            params[:staple] == "true" ? ("Staple") : "Nilch",
            params[:threehole] == "true" ? ("Three Hole Punch") : "Nilch", 
            params[:laminate] == "true" ? ("Laminate") : "Nilch",
            params[:clear_cover] == "true" ? ("Clear Cover") : "Nilch",
            params[:black_back] == "true" ? ("Black Back") : "Nilch"]
    return parms
  end


  def get_estimate
    estimate = 0.00
    pages = params[:pages].to_i  == 0 ? (1.00) : params[:pages].to_f
    #print pages.to_s+"\n"
    copies = params[:copies].to_i == 0 ? (1.00) : params[:copies].to_f
    #print copies.to_s+"\n"
    parms = get_appropiate_parameters(params)
    @costs = Cost.where(:option => parms).order(:per_page, :per_job)


    @costs.each do |cost|
      addCost = cost.per_job*copies + (cost.per_page*pages*copies)
      cost.cost_dependencies.each do |cd|
        if parms.include? cd.dependency_option
          addCost = cd.per_job*copies + (cd.per_page*pages*copies)
        end
      end
      estimate += addCost
    end
    respond_to do |format|
      format.json {
        render json: estimate
      }
    end
  end

  def get_dependencies
    cost_id = params[:cost_id]
    @cost = Cost.find(cost_id)
    @cost_dependencies = @cost.cost_dependencies.where(:cost_id => cost_id)
    @cost_dependencies.each do |cd|
    end
    respond_to do |format|
      format.json {
        render json: @cost_dependencies
      }
    end
  end

  def new_dependency
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @costs = Cost.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @costs }
    end
  end

  def show
  end

  def new
    @cost = Cost.new
    @new = true

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cost }
    end
  end

  def edit
    # GET /costs/1/edit
    @edit = true
    @cost = Cost.find(params[:id])
  end

  def create

    @cost = Cost.new(cost_params)
    @cost.category = @cost.category.strip
    @cost.option = @cost.option.strip
    if Cost.exists?(:category => @cost.category, :option => @cost.option)
      redirect_to action: 'update', id: Cost.where(:category => @cost.category, :option => @cost.option).first.id
    else
      respond_to do |format|
        if @cost.save
          format.html { redirect_to action: 'index', status: 303, notice: [true, 'Cost was successfully created.'] }
          format.json { render json: @cost, status: :created, location: @cost }
        else
          format.html { render action: "new" }
          format.json { render json: @cost.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    @cost = Cost.find(params[:id])
    @cost.category = @cost.category.strip
    @cost.option = @cost.option.strip
    respond_to do |format|
      if @cost.update_attributes(cost_params)
        format.html { redirect_to action: 'index', status: 303, notice: [true, 'Cost was successfully updated.'] }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cost.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cost = Cost.find(params[:id])
    @cost.destroy

    respond_to do |format|
      format.html { redirect_to costs_url }
      format.json { head :no_content }
    end
  end

private
  def cost_params 
    params.require(:cost).permit(:category, :option, :per_job, :per_page)
  end

end
