class Project < ActiveRecord::Base
  belongs_to :customer
  has_many :projectItems, dependent: :destroy
  has_many :historys, dependent: :destroy
end
