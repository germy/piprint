class AttachmentsController < ApplicationController
  before_filter :authorize
  before_action :set_attachment, only: [:show, :edit, :update, :destroy, :download, :queue]

  # GET /attachments
  # GET /attachments.json
  def index
    @attachments = Attachment.where("user_id = ?", current_user.id)
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new
  end

  # GET /attachments/1/edit
  def edit
  end

  def queue
    @attachment.update_attribute("num_queue", @attachment.num_queue + 1)
    system("python ~/piprint/scripts/test.py")
    flash[:notice] = "#{@attachment.file} has been queued"
    redirect_to attachments_path
  end

  # POST /attachments
  # POST /attachments.json
  def create
    @attachment = Attachment.new(attachment_params)
    @attachment.user_id = current_user.id
    @attachment.num_queue = 0
    respond_to do |format|
      if @attachment.save
        format.html { redirect_to @attachment, notice: 'Attachment was successfully created.' }
        format.json { render :show, status: :created, location: @attachment }
      else
        format.html { render :new }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attachments/1
  # PATCH/PUT /attachments/1.json
  def update
    respond_to do |format|
      if @attachment.update(attachment_params)
        format.html { redirect_to @attachment, notice: 'Attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @attachment }
      else
        format.html { render :edit }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to attachments_url, notice: 'Attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def download
    if current_user.id == @attachment.user_id then 
      send_file @attachment.file.current_path
    else 
      redirect_to attachments_url 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:file, :user_id, :num_queue)
    end
end
