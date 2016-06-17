class ProjectController < ApplicationController
  before_action :find_project, only: [:edit, :destroy,:update, :show]


  def index
    @projects = Project.all
    @newProject = Project.new
  end

  def show
    @newHistory = History.new
    @newFile = Attachment.new
    @newItem = Task.new
    @files = @project.attachments.paginate(:page => params[:filepage])
    if @project.customer.present?
      @customerfiles = @project.customer.attachments.paginate(:page => params[:customerfilepage])
    end
    if @project.component.present?
      @componentfiles = @project.component.attachments.paginate(:page => params[:componentfilepage])
    end
  end

  def create
    @project = Project.new(project_params)

    if project_params[:type] != "Reklamation"
      @project.customer = nil
      @project.title = "In der If drin gewesen!"
    end

    respond_to do |format|
      if @project.save
        add_History_from_project(@project)
        format.html { redirect_to project_index_path, success: 'Projekt wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { redirect_to project_index_path, danger: 'Projekt wurde nicht erstellt' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to project_index_path(customer: @customer), success: 'Projekt wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), success: 'Projekt wurde erfolgreich aktualisiert.'
    else
      redirect_to project_path(@project), alert: 'Projekt wurde nicht aktualisiert.'
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :customer_id, :component_id, :user_id, :lief_nr, :reklamation_lief, :type)
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def find_customer
    @customer = Customer.find(params[:customer])
  end

end
