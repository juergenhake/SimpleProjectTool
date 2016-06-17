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
    @project
    if attachment_params.has_key?(:project_id)
      find_project(attachment_params[:project_id])
      @attachment.project = @project
    end
    @task
    if attachment_params.has_key?(:task_id)
      find_task(attachment_params[:task_id])
      @attachment.task = @task
    end

    respond_to do |format|
      if @attachment.save
          add_History_from_attachment(@attachment,0)
          if attachment_params.has_key?(:customer_id)
            format.html { redirect_to customer_path(@customer), success: 'Datei wurde hochgeladen.' }
            format.json { render :show, status: :created, location: @history }
          end
          if attachment_params.has_key?(:component_id)
            format.html { redirect_to component_path(@component), success: 'Datei wurde hochgeladen.' }
            format.json { render :show, status: :created, location: @history }
          end
          if attachment_params.has_key?(:project_id)
            format.html { redirect_to project_path(@project), success: 'Datei wurde hochgeladen.' }
            format.json { render :show, status: :created, location: @history }
          end
          if attachment_params.has_key?(:task_id)
            format.html { redirect_to task_path(@task), success: 'Datei wurde hochgeladen.' }
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
        if attachment_params.has_key?(:project_id)
          format.html { redirect_to component_path(@project), danger: @attachment.errors }
          format.json { render json: @attachment.errors, status: :unprocessable_entity }
        end
        if attachment_params.has_key?(:task_id)
          format.html { redirect_to task_path(@task), danger: @attachment.errors }
          format.json { render json: @attachment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    add_History_from_attachment(@attachment,1)
    @path = root_path
    if @attachment.component.present?
      @path = component_path(@attachment.component)
    elsif @attachment.customer.present?
      @path = customer_path(@attachment.customer)
    elsif @attachment.project.present?
      @path = project_path(@attachment.project)
    elsif @attachment.task.present?
      @path = task_path(@attachment.task)
    end

    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to @path, success: 'Datei wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:file, :component_id, :customer_id, :project_id, :task_id)
  end

  def find_component(id)
    @component = Component.find(id)
  end

  def find_customer(id)
    @customer = Customer.find(id)
  end

  def find_project(id)
    @project = Project.find(id)
  end

  def find_task(id)
    @task = Task.find(id)
  end


  def find_attachment
    @attachment = Attachment.find(params[:id])
  end
end
