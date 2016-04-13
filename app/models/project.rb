class Project < ActiveRecord::Base
  belongs_to :component
  has_many :projectItems, dependent: :destroy
end
