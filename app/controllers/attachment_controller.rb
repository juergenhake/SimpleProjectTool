class AttachmentController < ApplicationController
  def create
    @attachment = Attachment.new(attachment_params)
    @attachment.user = current_user
    @component
    if attachment_params.has_key?(:component_id)
      find_component(attachment_params[:component_id])
      @attachment.component = @component
    end

    respond_to do |format|
      if @attachment.save
          format.html { redirect_to component_path(@component), success: 'Datei wurde hochgeladen.' }
          format.json { render :show, status: :created, location: @history }
      else
          format.html { redirect_to component_path(@component), danger: @attachment.errors }
          format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:file, :component_id)
  end

  def find_component(id)
    @component = Component.find(id)
  end
end
