class History < ActiveRecord::Base
  belongs_to :customer
  belongs_to :component
  belongs_to :project
  belongs_to :task
  belongs_to :user
end
