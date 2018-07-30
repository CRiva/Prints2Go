class RequestAttachmentsController < ApplicationController
  before_action :set_request_attachment, only: [:show, :edit, :update, :destroy]

  # GET /request_attachments
  # GET /request_attachments.json
  def index
    @request_attachments = RequestAttachment.all
  end

  # GET /request_attachments/1
  # GET /request_attachments/1.json
  def show
  end

  # GET /request_attachments/new
  def new
    @request_attachment = RequestAttachment.new
  end

  # GET /request_attachments/1/edit
  def edit
  end

  # POST /request_attachments
  # POST /request_attachments.json
  def create
    @request_attachment = RequestAttachment.new(request_attachment_params)

    respond_to do |format|
      if @request_attachment.save
        format.html { redirect_to @request_attachment, notice: 'Request attachment was successfully created.' }
        format.json { render :show, status: :created, location: @request_attachment }
      else
        format.html { render :new }
        format.json { render json: @request_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /request_attachments/1
  # PATCH/PUT /request_attachments/1.json
  def update
    respond_to do |format|
      if @request_attachment.update(request_attachment_params)
        format.html { redirect_to @request_attachment, notice: 'Request attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @request_attachment }
      else
        format.html { render :edit }
        format.json { render json: @request_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_attachments/1
  # DELETE /request_attachments/1.json
  def destroy
    id = @request_attachment.request_id
    @request_attachment.destroy
    flash[:success] = "Attachment was successfully deleted."
    respond_to do |format|
      format.html { redirect_to controller: "requests", action: "edit", id: "#{id}"}
      format.json { head :no_content }
    end
  end

  private
    def set_request_attachment
      @request_attachment = RequestAttachment.find(params[:id])
    end

    def request_attachment_params
      params.require(:request_attachment).permit(:request_id, :file)
    end
end
