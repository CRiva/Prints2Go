require 'net/smtp'
require 'net/http'
require 'net/https'
require 'uri'
require 'json'


class RequestsController < ApplicationController

  include RequestsHelper

  before_action only: [:edit, :destroy, :previewRequestBill] do 
    currentUsersOrAdmin
  end
  before_action only: [:complete, :show] do
    admin?
  end
  helper_method :sort_column, :sort_direction

  def currentUsersOrAdmin
    if Request.find(params[:id]).requester != session[:cas_user] 
      if !admin
        flash[:error] = "You are not allowed to do that to request."
        redirect_to action: 'index', :status => 303
      end
    end
  end

  def admin?
    if Request.admins.exclude? session[:cas_user]
      flash[:error] = "You are not allowed to do that"
      redirect_to action: 'index', :status => 303
    end
  end

  def index
    requestsToGrabIndex
  end

  def add_other_estimate
    @request = Request.find(params[:id])
    @request.otherestimate = params[:request][:otherestimate]
    @request.save
    if @request.errors.empty?
      flash[:success] = "You successfully updated the price of this print."
      redirect_to action: 'previewRequestBill', status: 303
    else
      flash[:alert] = "Unable to update price: "+@request.errors.full_messages.to_s
      redirect_to action: 'previewRequestBill', status: 303
    end
  end

  def preview
    if admin
      @requests = Request.where(:status => 'completed', :billed => false).paginate(:page => params[:page],:per_page => 10) rescue nil
    else
      @requests = Request.where(:requester => session[:cas_user], :status => 'completed', :billed => false).paginate(:page => params[:page],:per_page => 10) rescue nil
    end
    
  end

  def download
    @allRequests = Request.where(:status => 'completed', :billed => false)
    respond_to do |format|
        format.csv { 
          send_data(@allRequests.to_csv, :filename => "Prints2GoData.csv")
        }
      end
  end 


  def previewRequestBill
    @request = Request.find(params[:id])
  end

  def billed
    @request.billed = false
    @request.completion = Time.now.to_s
  end

  def list
  end

  def show
    @request = Request.find(params[:id])
    @request_attachments = @request.request_attachments.all
  end

  def new
    @request = Request.new
    @new = true

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @request }
    end
  end

  def edit
    @edit = true
    @request = Request.find(params[:id])
  end

  def create
    @request = Request.new(request_params)
    @request.requester = (params[:request][:requester] == "") ? session[:cas_user] : params[:request][:requester]
    if @request.requester != session[:cas_user]
      puts "Requestor #{session[:cas_user]} was not the inputted requester #{params[:request][:requester]}"
    end
    @request.pickup_date = Chronic.parse(params[:request][:pickup_date]) rescue nil
    @request.copies = (params[:request][:copies]).to_i 
    @request.originals = (params[:request][:originals]).to_i 
    @request.status = 'new'
    puts @request.errors.full_messages
    if @request.save 
      incident = {"incident" => {"name" => @request.jobtitle,
                          "category" => {"name" => "Printing"},
                          "subcategory" => {"name" => "Prints2Go"},
                          "priority" => "None",
                          "requester" => {"email" => @request.requester.to_s+"@westmont.edu"},
                          "assignee" => {"email" => "rvalencia@westmont.edu"},
                          "description" => @request.requester.to_s+" has requested a print job at http://prints2go.westmont.edu/requests/"+@request.id.to_s+"/edit"
                          }}
      Samanage.create_incident(payload: incident) if Rails.application.config.techmate_enabled
      if params[:request_attachments] 
        params[:request_attachments]['file'].each do |f|
          @request_attachment = @request.request_attachments.create!(:file => f)
        end
      end
      fname = session[:cas_extra_attributes]["givenName"][0]
      fullname = fname+" "+session[:cas_extra_attributes]["sn"][0]
      RequestMailer.send_confirmation_email_to_user(@request, fname).deliver_now
      RequestMailer.send_request_email_to_admin(@request, fullname).deliver_now

      flash[:success] = "Your request was submitted successfully, check your email for a confirmation message."
      redirect_to action: 'index', status: 303
    else
      render :new
    end
  end

  def update
    @request = Request.find(params[:id])
    @request.update_attributes!(request_params)
    @request.pickup_date = Chronic.parse(params[:request][:pickup_date]) rescue nil
    @request.copies = (params[:request][:copies]).to_i 
    @request.originals = (params[:request][:originals]).to_i 
    puts @request.errors.full_messages
    if @request.save
      if params[:request_attachments]
        params[:request_attachments]['file'].each do |f|
          @request_attachment = @request.request_attachments.create!(:file => f)
        end
      end
      flash[:success] = "Your request was updated successfully, check your email for a confirmation message."
      redirect_to action: 'index', status: 303 
    else 
      flash.now[:alert] = "Your request could not be saved because " + @request.errors.full_messages.to_s
      render :new
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    redirect_to action: 'index', status: 303
  end

  def complete
    @request = Request.find(params[:id])
    @request.status = 'completed'
    @request.billed = false
    @request.completion = Time.now.to_s
    @request.save

    redirect_to action: 'index', status: 303
  end

  def upload
  end

private 

  def sort_column
    Request.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def request_params 
    params.require(:request).permit(:threehole, :black_back, :binding, :billed, :clear_cover, :collate, :color, :color_copy, :copies, :cost, :costcenter, :costcenter_number, :cut, :estimate, :finish, :folding, :jobtitle, :laminate, :originals, :otherestimate, :pad, :pickup_date, :requester, :sides, :size, :special_info, :staple, :status, :stock, :weight, request_attachments_attributes: [:id, :request_id, :file])
  end
end
