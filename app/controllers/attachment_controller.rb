class AttachmentController < ApplicationController
  before_action :find_attachment, only: [:destroy]

  def create
    @attachment = Attachment.new(attachment_params)
    @attachment.user = current_user
    @component
    if attachment_params.has_key?(:component_id)
      find_component(attachment_params[:component_id])
      @attachment.component = @component
    end
    @customer
    if attachment_params.has_key?(:customer_id)
      find_customer(attachment_params[:customer_id])
      @attachment.customer = @customer
    end

    respond_to do |format|
      if @attachment.save
          add_History_from_attachment(attachment_params,@attachment)
          if attachment_params.has_key?(:customer_id)
            format.html { redirect_to customer_path(@customer), success: 'Datei wurde hochgeladen.' }
            format.json { render :show, status: :created, location: @history }
          end
          if attachment_params.has_key?(:component_id)
            format.html { redirect_to component_path(@component), success: 'Datei wurde hochgeladen.' }
            format.json { render :show, status: :created, location: @history }
          end

      else
        if attachment_params.has_key?(:customer_id)
          format.html { redirect_to customer_path(@customer), danger: @attachment.errors }
          format.json { render json: @attachment.errors, status: :unprocessable_entity }
        end
        if attachment_params.has_key?(:component_id)
          format.html { redirect_to component_path(@component), danger: @attachment.errors }
          format.json { render json: @attachment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy

    if @attachment.component.present?
      @component = @attachment.component
      @attachment.destroy
      respond_to do |format|
        format.html { redirect_to component_path(@component), success: 'Datei wurde erfolgreich entfernt.' }
        format.json { head :no_content }
      end
    end
    if @attachment.customer.present?
      @customer = @attachment.customer
      @attachment.destroy
      respond_to do |format|
        format.html { redirect_to customer_path(@customer), success: 'Datei wurde erfolgreich entfernt.' }
        format.json { head :no_content }
      end
    end

  end

  private

  def attachment_params
    params.require(:attachment).permit(:file, :component_id, :customer_id)
  end

  def find_component(id)
    @component = Component.find(id)
  end

  def find_customer(id)
    @customer = Customer.find(id)
  end

    def find_attachment
    @attachment = Attachment.find(params[:id])
  end
end
