class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :warning, :danger, :info


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit [:first_name, :last_name, :email, :password, :password_confirmation, roles: [] ] }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit [:first_name, :last_name, :email, :password, :password_confirmation, :current_password, roles: [] ] }
  end

  def add_History_from_attachment(params, attachment)
    @history = History.new
    @history.user = current_user
    @history.systemflag = true
    if params.has_key?(:customer_id)
      @history.customer = Customer.find(params[:customer_id])
    end
    if params.has_key?(:component_id)
      @history.component = Component.find(params[:component_id])
    end
    @history.message = "Die Datei " + attachment.file_file_name + " wurde von " + current_user.first_name + " " + current_user.last_name + " angehangen"
    @history.save
  end

  def add_History_from_component(component)
    @history = History.new
    @history.user = current_user
    @history.systemflag = true
    @history.component = component
    @history.message = "Das Bauteil wurde von " + current_user.first_name + " " + current_user.last_name + " angelegt"
    @history.save
  end
end
