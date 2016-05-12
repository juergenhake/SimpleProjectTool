class ComponentsController < ApplicationController
  before_action :find_component, only: [:destroy, :update, :edit, :show, :addCustomer, :addProject]
  def index
    @components = Component.all
    @newComponent = Component.new
  end

  def show
    getProjectsToAdd(@component)
    getCustomersToAdd
    @newHistory = History.new
    @newFile = Attachment.new
    @addCustomer = Component.new
    @addProject = Component.new
    @files = @component.attachments.paginate(:page => params[:filepage])
    @customers = @component.customers.paginate(:page => params[:customerpage])
    @projects = @component.projects.paginate(:page => params[:projectspage])
  end

  def create
    @component = Component.new(component_params)


    respond_to do |format|
      if @component.save
        add_History_from_component(@component)
        format.html { redirect_to components_path, success: 'Bauteil wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @component }
      else
        format.html { redirect_to new_component_path, danger: 'Bauteil wurde nicht erstellt' }
        format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @component.destroy
    respond_to do |format|
      format.html { redirect_to components_path, success: 'Bauteil wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def new
    @component = Component.new
  end

  def edit
  end

  def update
    if @component.update(component_params)
      redirect_to components_path, notice: 'Bauteil wurde erfolgreich aktualisiert.'
    else
      redirect_to components_path, alert: 'Bauteil wurde nicht aktualisiert.'
    end
  end

  def addCustomer
    find_customer(component_params[:customer_id])
    @component.customers << @customer
    if @component.save
      redirect_to component_path(@component), notice: 'Kunde wurde erfolgreich hinzugefügt.'
    else
      redirect_to component_path(@component), alert: 'Kunde wurde nicht hinzugefügt.'
    end
  end

  def addProject
    find_project(component_params[:projects_id])
    @component.projects << @project
    if @component.save
      redirect_to component_path(@component), notice: 'Projekt wurde erfolgreich hinzugefügt.'
    else
      redirect_to component_path(@component), alert: 'Projekt wurde nicht hinzugefügt.'
    end
  end


  private

  def component_params
    params.require(:component).permit(:component_id_sap, :description, :name, :customer_id, :projects_id)
  end

  def find_component
    @component = Component.find(params[:id])
  end

  def find_customer(id)
    @customer = Customer.find(id)
  end

  def find_project(id)
    @project = Project.find(id)
  end

  def getCustomersToAdd
      @addcustomers = Array.new
      @tmpcustomer = Customer.all

      if @tmpcustomer.count > 0
        @tmpcustomer.each do | customer |
          flag = true
          @component.customers.each do | c |
            if customer.id == c.id
              flag = false
            end
          end
          if flag
            @addcustomers << customer
          end
        end
      end
  end
end
