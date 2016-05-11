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

  def add_History_from_attachment(attachment, type)
    @history = History.new
    @history.user = current_user
    @history.systemflag = true

    if attachment.customer.present?
      @history.customer = attachment.customer
    end
    if attachment.component.present?
      @history.component = attachment.component
    end
    if attachment.project.present?
      @history.project = attachment.project
    end
    if type == 0
      @history.message = "Die Datei " + attachment.file_file_name + " wurde von " + current_user.first_name + " " + current_user.last_name + " angehangen"
    elsif type == 1
      @history.message = "Die Datei " + attachment.file_file_name + " wurde von " + current_user.first_name + " " + current_user.last_name + " gelöscht"

    end
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

  def add_History_from_project(project)
    @history = History.new
    @history.user = current_user
    @history.systemflag = true
    @history.project = project
    @history.message = "Das Projekt wurde von " + current_user.first_name + " " + current_user.last_name + " angelegt"
    @history.save
  end
end
