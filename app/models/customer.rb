class Customer < ActiveRecord::Base
  belongs_to :component
  has_many :projects, dependent: :destroy
  has_many :historys, dependent: :destroy
end
