class CustomerController < ApplicationController
  before_action :find_customer, only: [:edit, :destroy, :update, :show, :addProject, :addComponent]

  def index
    @customers = Customer.all
    @newCustomer = Customer.new
  end

  def show
    getComponentsToAdd
    getProjectsToAdd(@customer)
    @addProject = Customer.new
    @addComponent = Customer.new
    @newHistory = History.new
    @newFile = Attachment.new
    @files = @customer.attachments.paginate(:page => params[:filepage])
    @projects = @customer.projects.paginate(:page => params[:projectpage])
    @components = @customer.components.paginate(:page => params[:componentpage])
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        add_History_from_customer(@customer)
        format.html { redirect_to customer_index_path(component: customer_params[:component_id]), success: 'Kunde wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { redirect_to new_customer_path(component: customer_params[:component_id]), danger: 'Kunde wurde nicht erstellt' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customer_index_path(component: @component), success: 'Kunde wurde erfolgreich entfernt.' }
      format.json { head :no_content }
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), success: 'Kunde wurde erfolgreich aktualisiert.'
    else
      redirect_to customer_path(@customer), alert: 'Kunde wurde nicht aktualisiert.'
    end
  end

  def new
    @customer = Customer.new
  end

  def addProject
    find_project(customer_params[:projects_id])
    @customer.projects << @project
    if @customer.save
      redirect_to customer_path(@customer), notice: 'Projekt wurde erfolgreich hinzugefügt.'
    else
      redirect_to customer_path(@customer), alert: 'Projekt wurde nicht hinzugefügt.'
    end
  end

  def addComponent
    find_component(customer_params[:component_id])
    @customer.components << @component
    if @customer.save
      redirect_to customer_path(@customer), notice: 'Bauteil wurde erfolgreich hinzugefügt.'
    else
      redirect_to customer_path(@customer), alert: 'Bauteil wurde nicht hinzugefügt.'
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:customer_id_sap, :description, :name, :projects_id, :customer_id, :component_id)
  end

  def find_customer
    @customer = Customer.find(params[:id])
  end

  def find_component(id)
    @component = Component.find(id)
  end

  def find_project(id)
    @project = Project.find(id)
  end

  def getComponentsToAdd
      @addcomponents = Array.new
      @tmpcomponents = Component.all

      if @tmpcomponents.count > 0
        @tmpcomponents.each do | component |
          flag = true
          @customer.components.each do | c |
            if component.id == c.id
              flag = false
            end
          end
          if flag
            @addcomponents << component
          end
        end
      end
  end


end
