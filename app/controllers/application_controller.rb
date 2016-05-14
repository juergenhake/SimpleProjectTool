class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  require 'mathn'
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :init_objects_for_global_modals
  add_flash_types :success, :warning, :danger, :info



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit [:first_name, :last_name, :email, :password, :password_confirmation, roles: [] ] }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit [:first_name, :last_name, :email, :password, :password_confirmation, :current_password, roles: [] ] }
  end

  def init_objects_for_global_modals
    @newComponent = Component.new
    @newCustomer = Customer.new
    @newProject = Project.new
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
    if attachment.task.present?
      @history.task = attachment.task
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

  def add_History_from_project(project,message = nil)
    @history = History.new
    @history.user = current_user
    @history.systemflag = true
    @history.project = project
    if message.present?
      @history.message = message
    else
      @history.message = "Das Projekt wurde von " + current_user.first_name + " " + current_user.last_name + " angelegt"
    end
    @history.save
  end

  def add_History_from_task(task, message = nil)
    @history = History.new
    @history.user = current_user
    @history.systemflag = true
    @history.task = task
    if message.present?
      @history.message = message
    else
      @history.message = "Die Aufgabe wurde von " + current_user.first_name + " " + current_user.last_name + " angelegt"
    end
    @history.save
  end

  def add_History_from_customer(customer)
    @history = History.new
    @history.user = current_user
    @history.systemflag = true
    @history.customer = customer
    @history.message = "Der Kunde wurde von " + current_user.first_name + " " + current_user.last_name + " angelegt"
    @history.save
  end

  def getProjectsToAdd(object)
      @addprojects = Array.new
      @tmpprojects = Project.all
      if @tmpprojects.count > 0
        @tmpprojects.each do | project |
          flag = false
          if (project.component.blank? && project.customer.blank?)
            flag = true
            object.projects.each do | p |
              if project.id == p.id
                flag = false
              end
            end
          end
          if flag
            @addprojects << project
          end
        end
      end
  end

  def Projectprogress(project)
    allitems = project.tasks.count
    progressitems = project.tasks.where(finished: nil).count
    progress = (((allitems-progressitems)*100) / allitems)
    project.progress = progress
    if progress == 100
      project.finished_flag = true
      project.finished_at = DateTime.now
      message = "Projekt Abgesclossen! Alle Aufgaben des Projektes wurden Erledigt."
      add_History_from_project(project, message)
    end
    project.save
  end

end
