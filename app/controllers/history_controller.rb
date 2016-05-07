class HistoryController < ApplicationController

  def create
    @history = History.new(history_params)
    @history.user = current_user
    @component
    if history_params.has_key?(:component_id)
      find_component(history_params[:component_id])
      @history.component = @component
    end
    @customer
    if history_params.has_key?(:customer_id)
      find_customer(history_params[:customer_id])
      @history.customer = @customer
    end

    respond_to do |format|
      if @history.save
        if history_params.has_key?(:customer_id)
          format.html { redirect_to customer_path(@customer), success: 'Kommentar wurde erstellt.' }
          format.json { render :show, status: :created, location: @history }
        end
        if history_params.has_key?(:component_id)
          format.html { redirect_to component_path(@component), success: 'Kommentar wurde erstellt.' }
          format.json { render :show, status: :created, location: @history }
        end
      else
        if history_params.has_key?(:customer_id)
          format.html { redirect_to customer_path(@customer), danger: 'Kommentar wurde nicht erstellt.' }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
        if history_params.has_key?(:component_id)
          format.html { redirect_to component_path(@component), danger: 'Kommentar wurde nicht erstellt.' }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  def history_params
    params.require(:history).permit(:message, :component_id, :customer_id)
  end

  def find_component(id)
    @component = Component.find(id)
  end

    def find_customer(id)
    @customer = Customer.find(id)
  end
end
