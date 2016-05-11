class ProjectItemsController < ApplicationController
  before_action :find_item, only: [:edit, :destroy,:update, :finished, :show]
  before_action :find_project, only: [:new, :index, :edit, :destroy]

  def index
    @items = @project.projectItems
    @newitem = ProjectItem.new

  end

  def show
    finished
  end

  def create
    @item = ProjectItem.new(item_params)
    @project = Project.find(item_params[:project_id])

    respond_to do |format|
      if @item.save
        format.html { redirect_to project_path(@project), success: 'Aufgabe wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { redirect_to project_path(@project), danger: 'Aufgabe wurde nicht erstellt' }
        format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to project_items_path(project: @project), success: 'Projekt wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @item = ProjectItem.new
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to project_items_path(project: @item.project), notice: 'Aufgabe wurde erfolgreich aktualisiert.'
    else
      redirect_to project_items_path(project: @item.project), alert: 'Aufgabe wurde nicht aktualisiert.'
    end
  end

  def finished
    @item.finished = Time.now
    if @item.save
      redirect_to project_items_path(project: @item.project), notice: 'Aufgabe wurde erfolgreich aktualisiert.'
    else
      redirect_to project_items_path(project: @item.project), alert: 'Aufgabe wurde nicht aktualisiert.'
    end
  end

  private

  def item_params
    params.require(:project_item).permit(:title, :description, :start, :end, :user_id, :project_id)
  end

  def find_item
    @item = ProjectItem.find(params[:id])
  end

  def find_project
    @project = Project.find(params[:project])
  end
end
