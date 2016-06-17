class ComponentsController < ApplicationController
  before_action :find_component, only: [:destroy, :update, :edit, :show, :addCustomer, :addProject]
  def index
    @newComponent = Component.new
     @filterrific = initialize_filterrific(
        Component,
        params[:filterrific],
        available_filters: [],
      ) or return
      # Get an ActiveRecord::Relation for all students that match the filter settings.
      # You can paginate with will_paginate or kaminari.
      # NOTE: filterrific_find returns an ActiveRecord Relation that can be
      # chained with other scopes to further narrow down the scope of the list,
      # e.g., to apply permissions or to hard coded exclude certain types of records.
      @components = @filterrific.find.page(params[:page])

      # Respond to html for initial page load and to js for AJAX filter updates.
      respond_to do |format|
        format.html
        format.js
      end

    # Recover from invalid param sets, e.g., when a filter refers to the
    # database id of a record that doesn’t exist any more.
    # In this case we reset filterrific and discard all filter params.
    rescue ActiveRecord::RecordNotFound => e
      # There is an issue with the persisted param_set. Reset it.
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return


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
      redirect_to component_path(@component), success: 'Bauteil wurde erfolgreich aktualisiert.'
    else
      redirect_to component_path(@component), alert: 'Bauteil wurde nicht aktualisiert.'
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
