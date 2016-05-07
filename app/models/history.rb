class History < ActiveRecord::Base
  belongs_to :customer
  belongs_to :component
  belongs_to :project
  belongs_to :projectItems
  belongs_to :user
end
