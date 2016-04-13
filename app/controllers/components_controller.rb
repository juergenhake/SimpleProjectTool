class ComponentsController < ApplicationController
  before_action :find_customer, only: [:new, :index, :edit, :destroy]
  before_action :find_component, only: [:destroy, :update, :edit]
  def index
    @components = @customer.components
  end

  def show
  end

  def create
    @component = Component.new(component_params)
    @customer = Customer.find(component_params[:customer_id])

    respond_to do |format|
      if @component.save
        format.html { redirect_to components_path(customer: @customer), success: 'Bauteil wurde erfolgreich erstellt.' }
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
      format.html { redirect_to components_path(customer: @customer), success: 'Bauteil wurde erfolgreich entfernt.' }
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
      redirect_to components_path(customer: @customer), notice: 'Bauteil wurde erfolgreich aktualisiert.'
    else
      redirect_to components_path(customer: @customer), alert: 'Bauteil wurde nicht aktualisiert.'
    end
  end

  private

  def component_params
    params.require(:component).permit(:component_id_sap, :description, :name, :customer_id)
  end

  def find_customer
    @customer = Customer.find(params[:customer])
  end

  def find_component
    @component = Component.find(params[:id])
  end
end