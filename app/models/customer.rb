class Customer < ActiveRecord::Base
  belongs_to :component
  has_many :projects, dependent: :destroy
end
