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
  end

  def create
    @project = Project.new(project_params)

    case project_params[:type]
    when "Sonstige"
      @project.Sonstige!
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
    params.require(:project).permit(:title, :description, :customer_id, :component_id, :user_id, :lief_nr, :reklamation_lief)
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def find_customer
    @customer = Customer.find(params[:customer])
  end

end
