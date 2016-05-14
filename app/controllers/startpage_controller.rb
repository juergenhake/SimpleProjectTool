class StartpageController < ApplicationController
  before_action :findItemsByUser, only: [:index]
  before_action :findProjectsByUser, only: [:index]

  def index

  end

  def findItemsByUser
    @items = Task.where(user_id: current_user, finished: nil)
  end

  def findProjectsByUser
    @projects = Project.where(user_id: current_user, finished_at: nil)
  end
end
