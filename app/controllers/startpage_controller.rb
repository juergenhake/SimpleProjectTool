class StartpageController < ApplicationController
  before_action :findItemsByUser, only: [:index]

  def index

  end

  def findItemsByUser
    @items = Task.where(user_id: current_user)
    getUsersProjects
  end

  def getUsersProjects
    @projects = Array.new
    @items.each do |item|
      @projects.push(item.project)
    end
  end
end
