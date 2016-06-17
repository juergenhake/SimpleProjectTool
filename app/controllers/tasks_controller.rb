class TasksController < ApplicationController
   before_action :find_item, only: [:edit, :destroy,:update, :finished, :show]
  before_action :find_project, only: [:new, :index, :edit, :destroy]

  def show
    @newHistory = History.new
    @newFile = Attachment.new
    @files = @item.attachments.paginate(:page => params[:filepage])
    @projectfiles = @item.project.attachments.paginate(:page => params[:projectfilepage])
    if @item.project.customer.present?
      @customerfiles = @item.project.customer.attachments.paginate(:page => params[:customerfilepage])
    end
    if @item.project.component.present?
      @componentfiles = @item.project.component.attachments.paginate(:page => params[:componentfilepage])
    end
  end

  def create
    @item = Task.new(item_params)
    @project = Project.find(item_params[:project_id])

    respond_to do |format|
      if @item.save
        add_History_from_task(@item)
        Projectprogress(@item.project)
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
      Projectprogress(@item.project)
      add_History_from_task(@item,"Die Aufgabe wurde von " + current_user.first_name + " " + current_user.last_name + " als erledigt markiert.")
      redirect_to project_path(@item.project), notice: 'Aufgabe wurde erfolgreich aktualisiert.'
    else
      redirect_to project_path(@item.project), alert: 'Aufgabe wurde nicht aktualisiert.'
    end
  end

  private

  def item_params
    params.require(:task).permit(:title, :description, :start, :end, :user_id, :project_id)
  end

  def find_item
    @item = Task.find(params[:id])
  end

  def find_project
    @project = Project.find(params[:project])
  end
end
