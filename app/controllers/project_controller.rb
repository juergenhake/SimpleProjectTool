class ProjectController < ApplicationController
  before_action :find_project, only: [:edit, :destroy,:update]
  before_action :find_customer, only: [:new, :index, :edit, :destroy]

  def index
    @projects = @customer.projects

  end

  def show
  end

  def create
    @project = Project.new(project_params)
    @customer = Customer.find(project_params[:customer_id])

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_index_path(customer: @customer), success: 'Projekt wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { redirect_to project_index_path(customer: @customer), danger: 'Projekt wurde nicht erstellt' }
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
      redirect_to project_index_path(customer: @project.customer), notice: 'Projekt wurde erfolgreich aktualisiert.'
    else
      redirect_to project_index_path(customer: @project.customer), alert: 'Projekt wurde nicht aktualisiert.'
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :customer_id)
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def find_customer
    @customer = Customer.find(params[:customer])
  end
end
