class CustomerController < ApplicationController
  before_action :find_customer, only: [:edit, :destroy, :update]
  before_action :find_component, only: [:index, :edit, :destroy, :new]
  def index
    @customers = @component.customers
  end

  def show
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
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
      redirect_to customer_index_path(component: customer_params[:component_id]), notice: 'Kunde wurde erfolgreich aktualisiert.'
    else
      redirect_to customer_index_path, alert: 'Kunde wurde nicht aktualisiert.'
    end
  end

  def new
    @customer = Customer.new
  end

  private

  def customer_params
    params.require(:customer).permit(:customer_id_sap, :description, :name, :component_id)
  end

  def find_customer
    @customer = Customer.find(params[:id])
  end

  def find_component
    @component = Component.find(params[:component])
  end
end
