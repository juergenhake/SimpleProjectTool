class Component < ActiveRecord::Base
  belongs_to :customer
  has_many :projects, dependent: :destroy
end
