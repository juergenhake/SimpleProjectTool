class HistoryController < ApplicationController

  def create
    @history = History.new(history_params)
    @history.user = current_user
    @component
    if history_params.has_key?(:component_id)
      find_component(history_params[:component_id])
      @history.component = @component
    end

    respond_to do |format|
      if @history.save
          format.html { redirect_to component_path(@component), success: 'Kommentar wurde erstellt.' }
          format.json { render :show, status: :created, location: @history }
      else
        unless history_params[:component_id].blank?
          format.html { redirect_to component_path(@component), danger: 'Kommentar wurde nicht erstellt.' }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  def history_params
    params.require(:history).permit(:message, :component_id)
  end

  def find_component(id)
    @component = Component.find(id)
  end
end
