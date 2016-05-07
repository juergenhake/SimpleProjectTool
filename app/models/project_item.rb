class ProjectItem < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :historys, dependent: :destroy

end
